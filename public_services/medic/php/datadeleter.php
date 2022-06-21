<?php    

    session_start();
    require_once("./../../global/php/database/database.php");
    require_once("./../configs/config_db.php");    


    require_once("./../../global/config.php");    
    require_once("./../configs/config.php");    
    require_once("./../configs/startup_config.php");    


    $function = "";
    $optTable = "";
    $data="";

    $success = false;
    $msg = "";

    $id = -1;

    $paramError = false;

    
    

    if(isset($_POST["optTable"])){
        $optTable = $_POST["optTable"];
    }
    if(isset($_POST["function"])){
        $function = $_POST["function"];
    }
    else{
        $msg = ($msg == "" ? "" : "<br>") . "param <strong>function</strong> is missing!";
        $paramError=true;
    }
    if(isset($_POST["id"])){
        $id = $_POST["id"];
    }
    else{
        $msg .= ($msg == "" ? "" : "<br>") . "param <strong>id</strong> is missing!";
        $paramError=true;
    }

    if(!$paramError){

        if($data !== "[]" && $function !== ""){
            $data = json_decode($data, true);
            $db = new Database($database);
            if($db){


                if($optTable !== ""){
                    $sql = ""
                        ." select * from __definition_datasaver_custom_statements"
                        ." WHERE post_function_name = '".$db->escapeString($optTable)."'"
                            ." AND deactivated = 0"
                        ." ORDER BY sortorder";
                    $sqlqueryData = $db->getData($sql);

                    $tempSuccess = true;

                    
                    $sqlReplaceFrom = ["@@ID@@","@@SESSIONUSERID@@"];
                    $sqlReplaceTo = [$db->escapeString($id),$db->escapeString($_SESSION["userid"]) ];

                    if(count($sqlqueryData)>0){
                        foreach($sqlqueryData as $row){
                            if($tempSuccess){
                                $sql = str_replace($sqlReplaceFrom, $sqlReplaceTo, $row["sql_query"]);
                                $tempSuccess = $db->execute($sql);
                                if(!$tempSuccess){
                                    $msg .= ($msg == "" ? "" : "<br>") . "Database Error!<br>".$db->errorText();
                                }
                            }
                            
                        }
                    }

                    $success = $tempSuccess;


                }
                else{
                    $sqlReplaceFrom = ["@@ID@@"];
                    $sqlReplaceTo = [$db->escapeString($id)];
    
                    $sql = ""
                        ." select * from __definition_datasaver_custom_statements"
                        ." WHERE post_function_name = '".$db->escapeString($function)."'"
                            ." AND deactivated = 0"
                        ." ORDER BY sortorder";
                    $sqlqueryData = $db->getData($sql);
    
    
    
                    $functionConfig = getFunctionConfig($function);
                    $formConfig = getFormsConfig($function);
                    $tableConfig = getTableConfig($function);
    
                    if($functionConfig !== "" && $functionConfig !== "[]"){
                        $functionConfig = json_decode($functionConfig, true);
                        $formConfig = json_decode($formConfig, true);
    
                        
                        $mysqlTable = $functionConfig["mysql_table"];
                        $uniquecol = $functionConfig["uniquecol"];
                        $allowDelete = $functionConfig["doDeleteData"];
                        $DeleteInArchiv = $functionConfig["DoDeleteData_InArchiv"];
    
                        if($mysqlTable != "" && $uniquecol != "" && $allowDelete==1){

                            if($DeleteInArchiv == 1){
                                $sql = "UPDATE ".$mysqlTable." SET deleted = 1 WHERE ".$uniquecol." = ".$id;
                            }
                            else{
                                $sql = "DELETE FROM ".$mysqlTable." WHERE ".$uniquecol." = ".$id;
                            }
                            
                            
                            $success = $db->execute($sql);
    
                            if(!$success){
                                $msg .= ($msg == "" ? "" : "<br>") . "Database Error!<br>".$db->errorText();
                            }
                            else{
                                if(count($sqlqueryData)>0){
                                    foreach($sqlqueryData as $row){
                                        if($success){
                                            $sql = str_replace($sqlReplaceFrom, $sqlReplaceTo, $row["sql_query"]);
                                            $success = $db->execute($sql);
                                            if(!$success){
                                                $msg .= ($msg == "" ? "" : "<br>") . "Database Error!<br>".$db->errorText();
                                            }
                                        }
                                        
                                    }
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
                                $msg .= ($msg == "" ? "" : "<br>") . "delete is not allowed for this function!";
                            }
                        
                        }
                    }
                    else{
                        $msg .= ($msg == "" ? "" : "<br>") . "undefined function <strong>".$function."</strong>!";
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
?>