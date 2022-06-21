<?php


    session_start();
    require_once("./../../global/php/database/database.php");
    require_once("./../configs/config_db.php");    


    require_once("./../../global/config.php");    
    require_once("./../configs/config.php");    
    require_once("./../configs/startup_config.php");    


    $paramError=false;
    $msg = "";

    $viewtype = "";
    $function = "";


    if(isset($_POST["function"])){
        $function = $_POST["function"];
    }
    else{
        $msg = ($msg == "" ? "" : "<br>") . "param <strong>function</strong> is missing!";
        $paramError=true;
    }
    if(isset($_POST["type"])){
        $viewtype = $_POST["type"];
    }

    $viewtype = trim($viewtype);

    


    $definitions_formconfigs=[];
    $definitions_functionbuttons=[];
    $definitions_tableconfigs=[];
    $definitions_extraButtons=[];
    $function_config=[];
    $dropDownConfig=[];

    


    if(!$paramError){

        if($function !== ""){
            $db = new Database($database);
            if($db){
                $allowColumn = "";
                if($viewtype == "add"){
                    $allowColumn = "allowInAdd";
                }
                else if($viewtype == "edit"){
                    $allowColumn = "allowInEdit";
                }
                else if($viewtype == "view"){
                    $allowColumn = "allowInView";
                }

                $pageLoaderTitle = "";


                $sql = "select * "
                        .",(SELECT COUNT(*)> 0 FROM __definition_tableconfig where function_name = __definition_function.function_name AND is_quicksearch = 1) as allowQuicksearch"
                        ." ,(SELECT count(*) FROM __definition_additional_data where __definition_additional_data.function_name = __definition_function.function_name ".($allowColumn == "" ? "" : " AND " . $allowColumn . " = 1").")>0 as DoLoadAdditionalData"
                    ." FROM __definition_function"
                    ." WHERE function_name = '".$function."'";
                $data=$db->getData($sql);

                if(count($data) > 0){
                    if($data[0]["type"] == "table"){
                        $data[0]["doLoadData"] = 1;
                        $data[0]["doSaveData"] = 0;
                        $data[0]["doDeleteData"] = 1;
                    }
                    else if($viewtype == "edit"){
                        $data[0]["doLoaddata"] = 1;
                    }
                    else if($viewtype == "view"){
                        $data[0]["doLoaddata"] = 1;
                        $data[0]["doSaveData"] = 0;
                    }
                    else{
                        $data[0]["doLoadData"] = 0;
                    }

                    if($data[0]["type"] == "table"){
                        $data[0]["allowQuicksearch"] = 0;
                        $allowColumn="";
                    }
                    else{
                        $data[0]["doDeleteData"] = 0;
                    }
                      
                    /*
                    if($viewtype == "edit" || $viewtype == "add"){
                        $data[0]["DoLoadAdditionalData"] = 0;
                    }
                    */

                    $pageLoaderTitle = $function;
                    if($data[0]["type"] != "table" && $data[0]["type"] != "custom"){
                        $pageLoaderTitle.="_".$viewtype;
                    }
                        
                    $function_config = $data[0];
                }

                if(count($function_config) > 0){
                    $sql = "select * "
                    ." FROM __definition_function_buttons"
                    ." WHERE function_name = '".$function."'"
                    . ($allowColumn != "" ? " AND " . $allowColumn . " = 1" : "");

                    $data=$db->getData($sql);
                    foreach($data as $row){
                        if(checkIfUserHasRight($row["right_function_name"], $row["right_sub_function"])){
                            $definitions_functionbuttons[$row["button"]] = $row;
                        }
                    }

                    $sql = "SELECT * FROM __definition_extrabuttons "
                        ." where deactivated = 0 "
                            ." AND function_name = '".$function."'"
                            . ($allowColumn != "" ? " AND " . $allowColumn . " = 1" : "")
                        ." ORDER BY sortorder";
                    $data=$db->getData($sql);

                    foreach($data as $row){
                        if(checkIfUserHasRight($row["right_function_name"], $row["right_sub_function"])){
                            $definitions_extraButtons[] = $row;
                        }
                    }

                    if($function_config["type"] == "table"){
                        $sql = "select * from __definition_tableconfig"
                            ." WHERE function_name = '".$function."'"
                    
                            ." ORDER BY function_name, sortorder"
                        ;
                        $data=$db->getData($sql);
                        foreach($data as $row){
                            $definitions_tableconfigs[] = $row;
                        }
                    }
                    else if($function_config["type"] == "form"){
                        if($allowColumn != ""){

                            
                            
                            $sql = ""
                                ."SELECT "
                                    ."*"
                                    .", ".($viewtype == "view" ? 1 : 0) ." as isReadOnly"
                                ." FROM __definition_formconfig"
                                ." WHERE function_name = '".$function."'"
                                ." AND " . $allowColumn . " = 1"
                                ." ORDER BY form_group, sortorder";
    
                            $data=$db->getData($sql);
    
                            foreach($data as $row){
                                
                                $allowed = checkIfUserHasRight($row["right_function_name"], $row["right_sub_function"]);
    
                                if($allowed){
                                    $definitions_formconfigs[] = $row;
                                }   
                            }


                            $sql = " "
                                ." select * from __definition_dropdowns"
                                ." where `column_name` in ("
                                    ." SELECT columnname FROM __definition_formconfig"
                                    ." WHERE function_name = '".$function."'"
                                    ." AND " . $allowColumn . " = 1"
                                ." )";
                            $config = $db -> getData($sql);
    
                            foreach($config as $cfg){
                                $temp = [];
                
                                $sql = str_replace("@@LOCALE@@",$locale,$cfg["sql_query"]);
                                if(isset($_SESSION["userid"])){
                                    $sql = str_replace("@@USERID@@",$_SESSION["userid"],$sql);
                                }
                                else{
                                    $sql = str_replace("@@USERID@@",-1,$sql);
                                }
                                
                                $data = $db->getData($sql);
                
                                foreach($data as $row){
                                    $temp[] = ["id" => $row["uid"], "name" => str_replace("'","`",$row["name"])];
                                }
                
                                $dropDownConfig[$cfg["column_name"]] = $temp;
                            }



                        }
                        else{
                            $success = false;
                            $msg = "no empty type allowed for type form";
                        }
                    }

                }
                else{
                    $success = false;
                    $msg = "could not find config for ".$function;
                }            
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
        ,"pageTitle" => $pageLoaderTitle
        ,"functionconfig" => $function_config
        ,"formconfig" => $definitions_formconfigs
        ,"function_buttons" => $definitions_functionbuttons
        ,"tableconfig" => $definitions_tableconfigs
        ,"extraButtons" => $definitions_extraButtons
        ,"dropdownConfig" => $dropDownConfig
        ,"msg" => $msg
    ];

    echo json_encode($retArray);
?>