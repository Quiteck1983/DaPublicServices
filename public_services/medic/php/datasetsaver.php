<?php

    session_start();
    require_once("./../../global/php/database/database.php");
    require_once("./../configs/config_db.php");    


    require_once("./../../global/config.php");    
    require_once("./../configs/config.php");    
    require_once("./../configs/startup_config.php");    

    $function = "";
    $data="";

    $success = false;
    $msg = "";


    $id = -1;
    $requestedType = "";

    $paramError = false;
    $tempSuccess = true;

    if(isset($_POST["id"])){
        $id = $_POST["id"];
    }
    if(isset($_POST["function"])){
        $function = $_POST["function"];
    }
    else{
        $msg = ($msg == "" ? "" : "<br>") . "param <strong>function</strong> is missing!";
        $paramError=true;
    }
    if(isset($_POST["data"])){
        $data = $_POST["data"];
    }
    else{
        $msg .= ($msg == "" ? "" : "<br>") . "param <strong>data</strong> is missing!";
        $paramError=true;
    }
    if(isset($_POST["type"])){
        $requestedType = $_POST["type"];
    }
    else{
        $msg .= ($msg == "" ? "" : "<br>") . "param <strong>type</strong> is missing!";
        $paramError=true;
    }


    if(!$paramError){
        if($data !== "[]" && $function !== ""){
            $data = json_decode($data, true);
            $db = new Database($database);

            if($db){

                $sql = "SELECT * FROM __definition_function"
                    ." where function_name = '".$function."'";
                $sqldata = $db->getData($sql);

                if(count($sqldata) > 0){
                    $allowSave = 0;
                    if($requestedType == "add" || $requestedType == "edit"){
                        $allowSave = 1;
                    }

                    
                    $mysqlTable = $sqldata[0]["mysql_table"];
                    $uniquecol = $sqldata[0]["uniquecol"];



                    if($mysqlTable != "" && $uniquecol != "" && $allowSave==1){
                        $data["changedby"] = $_SESSION["userid"];
                        if($function == "form_files"  && $requestedType=="add"  && $id == -1){
                            $data["file_number"] = getFileID($db);
                        }
                        if($function == "form_officer" && $requestedType=="add" && $id == -1){
                            $data["password"] = MD5($data["password"]);
                        }
                        if($function == "form_files_emergency_contacts" && $requestedType=="add"){
                            $data["file_uid"] = $id;
                            $id=-1;
                        }

                        if($function == "form_usersettings"){
                            $id = $_SESSION["userid"];
                        }

    
    
                        if($tempSuccess){
                            if($id == -1){        
                                $data["createdby"] = $_SESSION["userid"];
                                $columns = "";
                                $values = "";
                                foreach($data as $fd => $value){
                                    $columns .= ($columns == "" ? "" : ",") . "`".$fd."`";
                                    $values .= ($values == "" ? "" : ",") . "'".$db->escapeString($data[$fd])."'";
                                }
    
                                $sql = "INSERT INTO ".$mysqlTable." (".$columns.") VALUES (".$values.")";
                            }
                            else{
                                $updateStr = "";
                                foreach($data as $fd => $value){
                                    $updateStr .= ($updateStr == "" ? "" : ",") . "`".$fd."` = '".$db->escapeString($data[$fd])."'";
                                }
    
                                $sql = "UPDATE ".$mysqlTable." SET ".$updateStr." WHERE `".$uniquecol."` = ".$db->escapeString($id); 
                            }
    
                            $success = $db->execute($sql);
    
                            if(!$success){
                                $msg .= ($msg == "" ? "" : "<br>") . "Database Error!<br>".$db->errorText();
                            }
    
    
                            if($function == "form_usersettings"){
                                $_SESSION["locale"] = $data["locale"];
                            }
                        }
                    }
                    else{
                        if($mysqlTable == ""){
                            $msg .= ($msg == "" ? "" : "<br>") . "undefined database table!";
                        }
                        if($uniquecol == ""){
                            $msg .= ($msg == "" ? "" : "<br>") . "undefined primary column!";
                        }
                        if($allowSave == 0){
                            $msg .= ($msg == "" ? "" : "<br>") . "save is not allowed for this function!";
                        }
                    
                    }
                    

                }
                else{
                    $msg .= ($msg == "" ? "" : "<br>") . "undefined function <strong>".$function."</strong>!";
                }

                if($success){
                    $db->commit();
                }
                else{
                    $db->rollback();
                }
                $db->close();
            }
            else{
                $success = false;
                $msg .= ($msg == "" ? "" : "<br>") . "cannot connect to database!";
            }
        }
        else{
            $success = false;
            if($data === "[]"){
                $msg .= ($msg == "" ? "" : "<br>") . "param <strong>data</strong> is empty!";
            }
            if($function === ""){
                $msg .= ($msg == "" ? "" : "<br>") . "param <strong>function</strong> is empty!";
            }
        }
    }
    

    $retArray = [
        "success" => $success
        ,"msg" => $msg
    ];

    echo json_encode($retArray);

    function getRandomFileID(){
        global $files_ending;
        return rand(10000000,99999999).'-'.rand(1000,9999)."-".$files_ending;
    }

    function getFileID($db){
        $file_id = getRandomFileID();
        $file_id_not_found = false;

        while(!$file_id_not_found){
            $sql = "select * from files where file_number = '".$file_id."'";
            $data2 = $db->getData($sql);

            if(count($data2) == 0){
                $file_id_not_found = true;
            }
            else{
                $file_id = getRandomFileID();
            }
        }

        return $file_id;
    }


?>