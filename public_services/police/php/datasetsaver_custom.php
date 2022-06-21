<?php

    session_start();
    require_once("./../../global/php/database/database.php");
    require_once("./../configs/config_db.php");    


    require_once("./../../global/config.php");    
    require_once("./../configs/config.php");    
    require_once("./../configs/startup_config.php");    


    $function = "";
    $success = false;
    $msg = "";
    $paramError = false;

    $postValues="";

    if(isset($_POST["values"])){
        $postValues = $_POST["values"];
    }
    else{
        $msg = ($msg == "" ? "" : "<br>") . "param <strong>values</strong> is missing!";
        $paramError=true;
    }
    if(isset($_POST["function"])){
        $function = $_POST["function"];
    }
    else{
        $msg = ($msg == "" ? "" : "<br>") . "param <strong>function</strong> is missing!";
        $paramError=true;
    }


    if(!$paramError){   
        $db = new Database($database);
        if($db){

            $sql = ""
                ." select * from __definition_datasaver_custom_statements"
                ." WHERE post_function_name = '".$db->escapeString($function)."'"
                    ." AND deactivated = 0"
                ." ORDER BY sortorder";
                    
                
            $sqlqueryData = $db->getData($sql);

            if(count($sqlqueryData)>0){
                $sqlReplaceFrom = [];
                $sqlReplaceTo = [];

                //write replaceStrings by $postValues
                $values = json_decode($postValues,true);
                $values["SESSIONUSERID"] = $_SESSION["userid"];

                foreach($values as $key => $value){
                    $sqlReplaceFrom[] = "@@".strtoupper($key)."@@";
                    $sqlReplaceTo[] = $db->escapeString($value);
                }

                $success = true;

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
            else{
                if($function == "group_rights_save"){
                    $values = json_decode($postValues,true);
                    $selections = $values["groupRightIds"];

    
                    $sql = "update group_rights SET updated = 0 where rankid = ".$db->escapeString($values["id"]);
                    $success = $db->execute($sql);
    
                    if(!$success){
                        $msg .= ($msg == "" ? "" : "<br>") . "Database Error!<br>".$db->errorText();
                    }
                    else{
    
                        if(count($selections)>0){
                            $rightids = $selections;
    
                            foreach($rightids as $rightid){
                                if($success){
                                    $sql = " " 
                                        ."insert into group_rights("
                                            ."rankid"
                                            .",right_id"
                                            .",updated"
                                            .",createdby"
                                            .",changedby"
                                        .") VALUES ("
                                            .$db->escapeString($values["id"])
                                            .",".$db->escapeString($rightid)
                                            .",1"
                                            .",".$db->escapeString($_SESSION["userid"])
                                            .",".$db->escapeString($_SESSION["userid"])
                                        .") on duplicate key update updated = values(`updated`), changedby = values(`changedby`) ";
                     
                                    $success = $db->execute($sql);
                                    if(!$success){
                                        $msg .= ($msg == "" ? "" : "<br>") . "Database Error!<br>".$db->errorText();
                                    }
                                
                                }
                            }
                        }
    
                        $sql = "delete from group_rights WHERE updated = 0 AND rankid = ".$db->escapeString($values["id"]);
                     
                        $success = $db->execute($sql);
                        if(!$success){
                            $msg .= ($msg == "" ? "" : "<br>") . "Database Error!<br>".$db->errorText();
                        }
                    }
    
                }
                else if($function == "files_add_entry"){
                    $values = json_decode($postValues,true);
                    $values["createdby"] = $_SESSION["userid"];
                    $values["changedby"] = $_SESSION["userid"];

                    $lawbook_ids = [];

                    foreach($values as $postkey => $value){
                        if(substr($postkey,0,11) == "lawbook_id_"){
                            if($value > 0){
                                $lawbook_ids[] = ["id" => str_replace("lawbook_id_","",$postkey), "value" => $value];        
                            }
                        }
                    }

                    $files_entry_uid = -1;

                    $sql = " "
                        ."INSERT INTO files_entries("
                            ."file_uid"
                            .",entry_content"
                            .",file_entry_number"
                            .",file_is_wanted"
                            .",type_of_entry"
                            .",fine"
                            .",detention_time"
                            .",createdby"
                            .",changedby"
                        .") VALUES ("
                            ."".$db->escapeString($values["file_uid"])
                            .",'".$db->escapeString($values["entry_content"])."'"
                            .",'".$db->escapeString(getFileEntryID($db))."'"
                            .",".$db->escapeString($values["file_is_wanted"])
                            .",".$db->escapeString($values["type_of_entry"])
                            .",".$db->escapeString($values["fine"])
                            .",".$db->escapeString($values["detention_time"])
                            .",".$db->escapeString($values["createdby"])
                            .",".$db->escapeString($values["changedby"])
                        .")";
                    $success = $db->execute($sql);
    
                    if(!$success){
                        $msg .= ($msg == "" ? "" : "<br>") . "Database Error!<br>".$db->errorText();
                    }
                    else{
                        $files_entry_uid = $db->getLastID();

                        foreach($lawbook_ids as $info){
                            if($success){
                                
                                $sql = " "
                                ."INSERT INTO files_entries_laws("
                                    ."files_entries_uid"
                                    .",law_uid"
                                    .",amount"
                                    .",createdby"
                                    .",changedby"
                                .") VALUES ("
                                    ."".$db->escapeString($files_entry_uid)
                                    .",'".$db->escapeString($info["id"])."'"
                                    .",".$db->escapeString($info["value"])
                                    .",".$db->escapeString($values["createdby"])
                                    .",".$db->escapeString($values["changedby"])
                                .")";
                                $success = $db->execute($sql);
    
                                if(!$success){
                                    $msg .= ($msg == "" ? "" : "<br>") . "Database Error!<br>".$db->errorText();
                                }

                            }
                            
                            
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
       
    
    

    $retArray = [
        "success" => $success
        ,"msg" => $msg
    ];

    echo json_encode($retArray);


    function getRandomFileEntryID(){
        global $files_ending;
        return rand(100000,999999).'-'.rand(1000000,9999999)."-".$files_ending;
    }

    function getFileEntryID($db){
        $file_id = getRandomFileEntryID();
        $file_id_not_found = false;

        while(!$file_id_not_found){
            $sql = "select * from files_entries where file_entry_number = '".$file_id."'";
            $data2 = $db->getData($sql);

            if(count($data2) == 0){
                $file_id_not_found = true;
            }
            else{
                $file_id = getRandomFileEntryID();
            }
        }

        return $file_id;
    }
?>