<?php

header('Content-Type: application/json');  // <-- header declaration

    $rootFolder =__DIR__.DIRECTORY_SEPARATOR."..".DIRECTORY_SEPARATOR."..".DIRECTORY_SEPARATOR;

    require_once("./../../global/files_cfg.php");
    $database_file = $rootFolder.$dataBaseFile;
    $databaseclassfile = dirname($database_file).DIRECTORY_SEPARATOR."database.php";

    require_once($database_file);
    require_once($databaseclassfile);

    doUpdatesIfNecessary();

    function doUpdatesIfNecessary(){
        global $dbconfigFileLSPD;
        global $dbconfigFileLSMD;
        global $rootFolder;

        $updateCommandFile = __DIR__.DIRECTORY_SEPARATOR."commands.txt";

        $retval = [];
        $retval["success"] = false;
        $retval["msg"] = "";

        if(file_exists($updateCommandFile)){
            $filecontent = file_get_contents($updateCommandFile);

            $filerows = explode("\r\n", $filecontent);

            $sqlStatements = [];

            $cases = [
                "police" => $rootFolder.$dbconfigFileLSPD
                ,"medic" => $rootFolder.$dbconfigFileLSMD
            ];

            $schemes = [
                "police" => ["replacefrom" => "`@@copscheme@@`", "replaceTo" => "unknown"]
                ,"medic" => ["replacefrom" => "`@@medicscheme@@`", "replaceTo" => "unknown"]
            ];
    
            foreach($cases as $index => $databaseCfgFile){
                require_once($databaseCfgFile);
                $schemes[$index]["replaceTo"] = "`" .$database ."`";
            }

            foreach($filerows as $row){
                if($row !== ""){
                    $query = $row;
                    foreach($schemes as $scheme){
                        if($scheme["replaceTo"] !== "unknown"){
                            $query = str_replace($scheme["replacefrom"], $scheme["replaceTo"], $query);
                        }    
                    }

                    $sqlStatements[] = $query; 
                }
            }

            $success = true;
            $db = new database("");
            foreach($sqlStatements as $statement){
                if($success){
                    $success = $db->execute($statement);
                    if(!$success){                        
                        $retval["success"] = false;
                        $retval["msg"] = "SQL-QUERY FAILED! -> ".$db->errorText();
                        echo json_encode($retval);
                        exit();
                    }
                }
            }

            if($success){

                if(unlink($updateCommandFile)){
                    $db->commit();
                    $retval["success"] = true;
                    $retval["msg"] = "all updates done!";
                }
                else{
                    $db->rollback();
                    $retval["success"] = false;
                    $retval["msg"] = "update_file delete failed, Database rollback!";
                }

                echo json_encode($retval);
                
            }
            else{
                $db->rollback();
            
            }
            $db->close();
        }
        else{
            $retval["success"] = true;
            $retval["msg"] = "no updates available";
            echo json_encode($retval);
        }
    }

?>