<?php
    error_reporting(E_ERROR);
    require_once("../../global/files_cfg.php");

    $function = "";

    if(isset($_POST["function"])){
        $function = $_POST["function"];
    }

    $retval=[];
    $retval["success"] = false;
    $retval["msg"] = "";


    if($function == "test_db_connection"){
        $servername   = $_POST["servername"];
        $username = $_POST["user"];
        $password = $_POST["password"];

        $retval = testDatabaseConnection($servername, $username, $password);
    }
    else if($function == "save_db_config"){
        $servername   = $_POST["servername"];
        $username = $_POST["user"];
        $password = $_POST["password"];
        $scheme_cops = $_POST["scheme_cops"];
        $scheme_medics = $_POST["scheme_medics"];
        
        $tempretval = testDatabaseConnection($servername, $username, $password);
        $countError = 0;
        
        if($tempretval["success"]){

            $connectionphpContent = getConnectionPHP($servername, $username, $password);
            $dbconfigphp_lspd = getDBConfig($scheme_cops);
            $dbconfigphp_lsmd = getDBConfig($scheme_medics);

        
            $dir = "..".DIRECTORY_SEPARATOR."..";
            deleteFile($dir.$dataBaseFile);
            deleteFile($dir.$dbconfigFileLSPD);
            deleteFile($dir.$dbconfigFileLSMD);


            $countError = 0;

            writeFile("Global-Databaseconfig", $dir.$dataBaseFile, $connectionphpContent);

            if($countError == 0){
                writeFile("police/configs/config_db.php", $dir.$dbconfigFileLSPD, $dbconfigphp_lspd);

                if($countError == 0){
                    writeFile("medic/configs/config_db.php", $dir.$dbconfigFileLSMD, $dbconfigphp_lsmd);
                }
            }

            if($countError == 0){
                $retval["success"] = true;
                $retval["msg"] = "all files created";
            }           
        }
        else{
            $retval = $tempretval;
        }
    }
    else if($function == "save_system_config"){
        $locale = $_POST["language"];
        $servername = $_POST["servername"];
        $systemuser = $_POST["system_user"];
        $system_user_pass = $_POST["system_user_pass"];

        $locale = strtolower($locale);

        if($locale != "en" && $locale != "de"){
            $locale = "en";
        }


        
        $dir = "..".DIRECTORY_SEPARATOR."..";
        
        $sqlfilepath = getSQLFilePath();

        deleteFile($sqlfilepath);
        deleteFile($dir.$configFile);


        $sql = "";

        $tempError = false;
        if(file_exists($dir.$dbconfigFileLSPD)){
            require_once($dir.$dbconfigFileLSPD);
            $copsDatabase = $database;
            if($copsDatabase != ""){
                $sql.=getExtraSQLStatements($copsDatabase, $systemuser, $system_user_pass, $locale);
            }
            else{
                $tempError=true;    
            }
            
        }
        else{
            $tempError=true;
        }

        $database="";
        
        if(!$tempError){
            if(file_exists($dir.$dbconfigFileLSMD)){
                require_once($dir.$dbconfigFileLSMD);
                $medicsDataBase = $database;
                if($medicsDataBase != ""){
                    $sql.=getExtraSQLStatements($medicsDataBase, $systemuser, $system_user_pass, $locale);
                }
                else{
                    $tempError = true;
                }
                
            }
            else{
                $tempError=true;
            }
        }
        
        if($tempError){
            $retval["success"] = false;
            $retval["msg"] = "could not write sqlfile correctly due to missing or wrong config!";
        }
        else{
            $countError = 0;

            writeFile("install/sql/extraSQL.sql", $sqlfilepath, $sql);

            if($countError == 0){
                $configFileContent = configFileGlobal($servername, $locale);
                writeFile("global/config.php", $dir.$configFile, $configFileContent );

                if($countError == 0){
                    $configFileContent = configFileBySystem("police");
                    writeFile("police/configs/config.php", $dir.$configFileLSPD, $configFileContent);

                    if($countError == 0){
                        $configFileContent = configFileBySystem("medic");
                        writeFile("police/configs/config.php", $dir.$configFileLSMD, $configFileContent);
                    }
                }

            }

            if($countError == 0){
                $retval["success"] = true;
                $retval["msg"] = "config files written!";
            }
        }      
    }

    else if($function == "reset_db_config"){
        
        $dir = "..".DIRECTORY_SEPARATOR."..";

        deleteFile($dir.$dataBaseFile);
        deleteFile($dir.$dbconfigFileLSPD);
        deleteFile($dir.$dbconfigFileLSMD);

        
        $retval["success"] = true;
        $retval["msg"] = "database config resetted";
    }
    else if($function == "reset_software_config"){
        $sqlfilepath = getSQLFilePath();

        deleteFile($sqlfilepath);
        deleteFile($dir.$configFile);
        deleteFile($dir.$configFileLSPD);
        deleteFile($dir.$configFileLSMD);

        
        $retval["success"] = true;
        $retval["msg"] = "system config resetted";
    }

    echo json_encode($retval);




    function testDatabaseConnection($host, $username, $password){
        $conn = new mysqli($host, $username, $password);

        $retval = [];
        
        if ($conn->connect_error) {
            
            $retval["success"] = false;
            $retval["msg"] = "Connection failed: " . $conn->connect_error;
        }
        else{
            $retval["success"] = true;
            $retval["msg"] = "Connected successfully";
        }

        return $retval;

    }

    function deleteFile($filepath){
        if(file_exists($filepath)){
            unlink($filepath);
        }
    }


    function writeFile($fileexplain, $filepath, $content2write){
        global $retval;
        global $countError;

        if(file_put_contents($filepath, $content2write)){
            if(file_exists($filepath)){
                $content = file_get_contents($filepath);
                if($content != $content2write){
                    $countError++;
                    $retval["success"] = false;
                    $retval["msg"] = "file not correctly written -> ".$fileexplain;
                }
            }
            else{
                $retval["success"] = false;
                $retval["msg"] = "file does not exists ".$fileexplain;
                $countError++;
            }

        }
        else{
            $countError++;
            $retval["success"] = false;
            $retval["msg"] = "could not write file -> ".error_get_last()["message"]." - ".$fileexplain;
        }



    }


    function configFileBySystem($type){

        $tempDir = str_replace(DIRECTORY_SEPARATOR."install".DIRECTORY_SEPARATOR."php","",__DIR__);
        
        if(strpos($tempDir,"\\") !== false){
            $tempDir = str_replace("\\","/",$tempDir);
        }
        
        $serverlocation = str_replace($_SERVER["DOCUMENT_ROOT"],"",$tempDir);

        if(substr($serverlocation,-1) != "/"){
            $serverlocation.="/";
        }
        $serverlocation .= $type."/";

        $phpFileContent = "";
        $phpFileContent.="<?php\n";
        $phpFileContent.=getFileHeader(true);
        $phpFileContent.="\n";
        $phpFileContent.="\t\$http = 'http://';\n";
        $phpFileContent.="\tif(isset(\$_SERVER[\"HTTPS\"])){\n";
        $phpFileContent.="\t\t\$http = 'https://';\n";
        $phpFileContent.="\t}\n";
        $phpFileContent.="\t\$serverAddress = \$http.\$_SERVER[\"SERVER_NAME\"].'".$serverlocation."'\n";
        $phpFileContent.="?>";

        return $phpFileContent;
    }


    function configFileGlobal($servername, $locale){

        $phpFileContent = "";
        $phpFileContent.="<?php";
        $phpFileContent.="\n";
        $phpFileContent.=getFileHeader(true);
        $phpFileContent.="\t";
        $phpFileContent.='$locale = "'.$locale.'";';
        $phpFileContent.="\n";
        $phpFileContent.="\t";
        $phpFileContent.='$servername = "'.addslashes($servername).'";';
        $phpFileContent.="\n";
        $phpFileContent.="?>";

        return $phpFileContent;

    }


    function getConnectionPHP($servername, $username, $password){
        $phpFileContent = "";
        $phpFileContent.="<?php\n";
        $phpFileContent.=getFileHeader(true);
        $phpFileContent.="\tfunction getConnectionData(\$database=''){\n";
        $phpFileContent.="\t\treturn [\n";
        $phpFileContent.="\t\t\t'host'=>'".addslashes($servername)."'\n";
        $phpFileContent.="\t\t\t,'user'=>'".addslashes($username)."'\n";
        $phpFileContent.="\t\t\t,'pass'=>'".addslashes($password)."'\n";
        $phpFileContent.="\t\t\t,'database'=>\$database\n";
        $phpFileContent.="\t\t];\n";
        $phpFileContent.="\t}\n";
        $phpFileContent.="?>";
        return $phpFileContent;
    }

    function getDBConfig($databaseName){
        $phpFileContent = "";
        $phpFileContent.="<?php\n";
        $phpFileContent.=getFileHeader(true);
        $phpFileContent.="\t\$database='".addslashes($databaseName)."';\n";
        $phpFileContent.="?>";
        return $phpFileContent;
    }

    
    function getFileHeader($autocreate){
        $licenseFile = "..".DIRECTORY_SEPARATOR."..".DIRECTORY_SEPARATOR."install".DIRECTORY_SEPARATOR."license".DIRECTORY_SEPARATOR."LICENSE.txt";

        if(file_exists($licenseFile)){
            $filecontent = file_get_contents($licenseFile);
    
            return $filecontent."\n\n";
        }
        else{
            echo json_encode(["success" => false, "msg" => "license file does not exists"]);
            exit();
        }
    }

    function getExtraSQLStatements($scheme, $system_username, $system_usernamepassword, $locale){
        $pwd = md5($system_usernamepassword);
        return "ALTER TABLE `".$scheme."`.`registered_user` CHANGE COLUMN `locale` `locale` VARCHAR(45) NOT NULL DEFAULT '".$locale."' ;\n"
            ."INSERT INTO ".$scheme.".registered_user(loginname, `password`, first_name, last_name, rankid ) VALUES ('".addslashes($system_username)."','".$pwd."','System', 'User', 9999);\n"
        ;
    }

    
    function getSQLFilePath(){
        return "..".DIRECTORY_SEPARATOR."..".DIRECTORY_SEPARATOR."install".DIRECTORY_SEPARATOR."sql".DIRECTORY_SEPARATOR."extraSQL.sql";
    }
    
    
?>