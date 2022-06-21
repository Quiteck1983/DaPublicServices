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
    $valueArray=[];
    $additionalValues=[];
    
    $fields = [];

    $paramError = false;

    $quicksearch = "";
    $id = -1;

    
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


    if(!$paramError){

        if($function !== ""){
            $db = new Database($database);
            if($db){

                $sqlReplaceFrom = ["@@USERID@@","@@ID@@",'@@LOCALE@@'];
                $sqlReplaceTo = [$_SESSION["userid"],$id, $locale];

                getAdditionalValues($db, $function);
            }
            else{
                $success = false;
                $msg .= ($msg == "" ? "" : "<br>") . "cannot connect to database!";
            }
        }
        else{           
            if($function === ""){
                $msg .= ($msg == "" ? "" : "<br>") . "param <strong>function</strong> is empty!";
            }


        }

    }

    
    $retArray = [
        "success" => true
        ,"additionalValues" => $additionalValues
        ,"msg" => $msg
    ];

    echo json_encode($retArray);

    function getAdditionalValues($db, $function){
        global $additionalValues;
        global $sqlReplaceFrom;
        global $sqlReplaceTo;

        $sql = ""
            ." select * from __definition_additional_data"
            ." where function_name = '".$db->escapeString($function)."'"
            ." ORDER BY sortorder";
        $data=$db->getData($sql);

        foreach($data as $line){
            $sqltemp = str_replace($sqlReplaceFrom, $sqlReplaceTo, $line["sql_query"]);
            $tempData = $db->getData($sqltemp);

            if($line["type"] == "array"){
                $additionalValues[$line["additional_data_type"]] = [];
                $additionalValues[$line["additional_data_type"]]["type"] = $line["type"];
                if(count($tempData)>0){
                    foreach($tempData[0] as $columnname => $value){
                        $additionalValues[$line["additional_data_type"]][$columnname] = $value;
                    }
                }
            }
            else if($line["type"] == "json"){
                $additionalValues[$line["additional_data_type"]] = [];
                $additionalValues[$line["additional_data_type"]]["type"] = $line["type"];
                $additionalValues[$line["additional_data_type"]]["values"] = $tempData;

            }
            else if($line["type"] == "table"){            
                $additionalValues[$line["additional_data_type"]] = [];
                $additionalValues[$line["additional_data_type"]]["values"] = [];
                $additionalValues[$line["additional_data_type"]]["header"] = [];
                $additionalValues[$line["additional_data_type"]]["type"] = $line["type"];

                foreach($tempData as $index => $values){
                    if($index == 0){
                        foreach($values as $column => $val){
                            $additionalValues[$line["additional_data_type"]]["header"][] = $val;
                        }
                    }
                    else{
                        foreach($additionalValues[$line["additional_data_type"]]["header"] as $fd){
                            $additionalValues[$line["additional_data_type"]]["values"][$index-1][] = ["id" => $fd, "value" => $values[$fd]];
                        }
                    }
                }
            }
            
        }        
    }
?>