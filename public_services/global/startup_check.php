<?php

    function checkIfDatabaseCreated($type){
        global $dataBaseFile;
        global $dbconfigFileLSPD;
        global $dbconfigFileLSMD;

        $dir=__DIR__.DIRECTORY_SEPARATOR."..";

        
        $database_file = $dir.$dataBaseFile;
        $databaseclassfile = dirname($database_file).DIRECTORY_SEPARATOR."database.php";

        if($type == "police"){
            $databaseschema_file = $dir.$dbconfigFileLSPD;
        }
        else if($type == "medic"){
            $databaseschema_file = $dir.$dbconfigFileLSMD;
        }

        $success = false;        

        if(file_exists($database_file)){
            if(file_exists($databaseschema_file)){
                require_once($databaseschema_file);
                require_once($database_file);
                require_once($databaseclassfile);
    
                $thisDataBase = $database;
    
                $db = new Database();
    
                $sql = "SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = '".$thisDataBase."'";
                $schemas = $db->getData($sql);
                
                if(count($schemas)>0){
                    $sql = "show tables from ".$thisDataBase."";
                    $tables = $db->getData($sql);
                    if(count($tables)>15){
                        $success = true;
                    }    
                }
            }
            
        }




        return $success;
    }


    function checkIfDatabaseIsConfigured(){
        global $dataBaseFile;
        global $dbconfigFileLSPD;
        global $dbconfigFileLSMD;        

        $retval = true;
        if(!file_exists(__dir__.DIRECTORY_SEPARATOR."..".$dataBaseFile)){
            $retval = false;
        }
        if(!file_exists(__dir__.DIRECTORY_SEPARATOR."..".$dbconfigFileLSPD)){
            $retval = false;
        }
        if(!file_exists(__dir__.DIRECTORY_SEPARATOR."..".$dbconfigFileLSMD)){
            $retval = false;
        }
        return !$retval;
    }

    function checkIfSoftwareIsConfigured(){
        global $configFile;
        global $configFileLSPD;
        global $configFileLSMD;
        
        $retval = true;
        if(!file_exists(__Dir__.DIRECTORY_SEPARATOR."..".$configFile)){
            $retval = false;
        }
        if(!file_exists(__Dir__.DIRECTORY_SEPARATOR."..".$configFileLSPD)){
            $retval = false;
        }
        if(!file_exists(__Dir__.DIRECTORY_SEPARATOR."..".$configFileLSMD)){
            $retval = false;
        }
        return !$retval;

    }


    
?>