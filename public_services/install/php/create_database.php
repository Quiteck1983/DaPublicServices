<?php

    $rootFolder =__DIR__.DIRECTORY_SEPARATOR."..".DIRECTORY_SEPARATOR."..".DIRECTORY_SEPARATOR;

    require_once("./../../global/files_cfg.php");

    $database_file = $rootFolder.$dataBaseFile;
    $databaseclassfile = dirname($database_file).DIRECTORY_SEPARATOR."database.php";

    require_once($database_file);
    require_once($databaseclassfile);



    $retval = [
        "success" => false
        ,"msg" => ""
    ];


    $sqlStatements = [];

    $cases = [
        "police" => $rootFolder.$dbconfigFileLSPD
        ,"medic" => $rootFolder.$dbconfigFileLSMD
    ];

    $sqlfiles = [
        "police" => $rootFolder.$sqlFileLSPD
        ,"medic" => $rootFolder.$sqlFileLSMD
        ,"" => $rootFolder.$sqlFileExtra
    ];

    $databaseSchemes = [""=>""];

    foreach($cases as $index => $databaseCfgFile){
        require_once($databaseCfgFile);

        $db = new Database("");

        $databaseSchemes[$index] = $database;

        $sql = "DROP SCHEMA IF EXISTS `".$database."`";
        $success = $db->execute($sql);
		
        if($success){
            $sql = "CREATE SCHEMA `".$database."` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin ;";
            $success = $db->execute($sql);
        }

        if($success){
            $db->rollback();
        }
        else{
            $retval["msg"] = $db->errorText();

            echo json_encode($retval);
            exit();
        }

        $db->close();
    }

    foreach($sqlfiles as $index => $filepath){
        if(file_exists($filepath)){
            $sqlStatements = getSqlStatementsByFile($filepath);



            if(count($sqlStatements)>0){
                $success = true;

                $db = new database($databaseSchemes[$index]);
                foreach($sqlStatements as $statement){
                    if($success){
                        $success = $db->execute($statement);
                        if(!$success){

                            $retval["msg"] = $db->errorText();
                            echo json_encode($retval);
                            exit();
                        }
                    }
                }

                if($success){
                    $db->commit();
                }
                else{
                    $db->rollback();
                }
                $db->close();

            }
        }
        else{
            $retval["msg"] = "sqlfile for ".$index." is missing";
            echo json_encode($retval);
            exit();
        }
    }

    $retval["success"] = true;
    $retval["msg"] = "Database created!";
    echo json_encode($retval);


    
    function getSqlStatementsByFile($sqlFile){
        $sqlStatements=[];
        $filecontent = file_get_contents($sqlFile);

        $filerows = explode("\n",$filecontent);
        $currentRow = "";

        foreach($filerows as $row){

            if($row != ""){

                $doRow = (substr(trim($row),0,10) == "CONSTRAINT" ? 0:1);

                if($doRow){
                    if(substr(trim($row),0,2) == "/*"){
                        $doRow = 0;
                    }
                    if(substr(trim($row),0,2) == "--"){
                        $doRow = 0;
                    }
                }


                
                if($doRow){

                    if(strpos($row,"DROP TABLE ") !== false){
                        $currentRow = " ";
                    }
                    else if(strpos($row,"INSERT INTO ") !== false){
                        $currentRow = " ";
                    }
                    else if(strpos($row,"CREATE TABLE ") !== false){
                        $currentRow = " ";
                    }
                    else if(strpos($row,"ALTER TABLE ") !== false){
                        $currentRow = " ";
                    }
                    
                    
                    
                    if($row != "" && $currentRow != ""){
                        $currentRow.=$row;
        
                        if(strpos($row,";",) !== false){
                            $sqlStatements []= $currentRow;
                            $currentRow="";
        
                        }
                    }
                }
                else{
                    if(substr($currentRow,-1) == ","){
                        $currentRow = substr($currentRow,0,strlen($currentRow)-1);
                    }
                }

                
            }
        }
        return $sqlStatements;
    }
    




?>