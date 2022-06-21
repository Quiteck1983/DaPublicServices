<?php

    if(isset($_SESSION["locale"])){
        if($_SESSION["locale"] != ""){
            $locale = $_SESSION["locale"];
        }
    }


    
    $user_loggedin = false;
    $limitPerPage = 10;

    $files_ending = "COP";


    $db = new Database($database);

    $definitions_functions = [];
    $definitions_functionbuttons = [];
    $definitions_tableconfigs = [];
    $definitions_formconfigs = [];
    $definitions_extraButtons = [];
    $translations = [];

    $function_rights_connection = [];

    $rights = [];
    $rights["control_centre"]=[];
    $rights["control_centre"]["reset_patrols"] = false;
    $rights["control_centre"]["set_patrol_status"] = false;
    $rights["control_centre"]["set_officer_status"] = false;
    $rights["control_centre"]["set_officer_to_patrol"] = false;
    $rights["control_centre"]["set_patrol_area"] = false;

    if($db){

        /**
         * retrive translations
         */
        $sql = "SELECT * FROM __definition_languages_values where locale = '".$locale."'";
        $translationData= $db -> getData($sql);

        foreach($translationData as $row){

            if(!isset($translations[$row["programmtype"]])){
                $translations[$row["programmtype"]]=[];
            }
            if(!isset($translations[$row["programmtype"]][$row["keyvalue"]])){
                $translations[$row["programmtype"]][$row["keyvalue"]] = str_replace("'","`",$row["translation"]);
            }
        }

        /**
         * retrive all defined rights
         */
        $sql = "select * from __definition_rights";
        $rightsData= $db -> getData($sql);

        foreach($rightsData as $right){
            if(!isset($rights[$right["function_name"]])){
                $rights[$right["function_name"]] = [];    
            }
            $rights[$right["function_name"]][$right["sub_function"]]=false;

        }


        
        /**
         * check for user login
         */
        if(isset($_SESSION["userid"]) && $_SESSION["userid"] !== ""){

            $sql = "SELECT rankid from registered_user WHERE userid = ".$_SESSION["userid"];
            $temp = $db->getData($sql);


            if(count($temp)>0){
                /**
                 * if rankid 9999 allow everyhing (9999 = Systemuser)
                 */
                if($temp[0]["rankid"] == 9999){
                    $rights["control_centre"]["reset_patrols"] = true;
                    $rights["control_centre"]["set_patrol_status"] = true;
                    $rights["control_centre"]["set_officer_status"] = true;
                    $rights["control_centre"]["set_officer_to_patrol"] = true;
                    $rights["control_centre"]["set_patrol_area"] = true;

                    foreach($rightsData as $right){
                        $rights[$right["function_name"]][$right["sub_function"]]=true;
                    }
                }
                else{

                    /**
                     * check if user is control_centre and allow control_centre rights
                     */
                    $sql = "select * from registered_user where is_control_centre = 1 AND userid = ".$_SESSION["userid"];
                    $controlCentreData = $db->getData($sql);
                    
                    
                    if(count($controlCentreData)>0){        
                        $rights["control_centre"]["reset_patrols"] = true;
                        $rights["control_centre"]["set_patrol_status"] = true;
                        $rights["control_centre"]["set_officer_status"] = true;
                        $rights["control_centre"]["set_officer_to_patrol"] = true;
                        $rights["control_centre"]["set_patrol_area"] = true;
                    }
        
                    /**
                     * get user rights
                     */
                    $sql = ""
                        ." SELECT __definition_rights.* FROM group_rights"
                        ." left join __definition_rights on __definition_rights.uid = group_rights.right_id"
        
                        ." where rankid = (select rankid from registered_user where userid = ".$_SESSION["userid"].")";
                    $rightsData= $db -> getData($sql);
        
                    foreach($rightsData as $right){
                        $rights[$right["function_name"]][$right["sub_function"]]=true;
        
                    }
                }
            }

            

        }

        /**
         * read rights for functions
         */
        $sql = "SELECT * FROM __definition_function_rights";
        $data=$db->getData($sql);
        foreach($data as $row){
            $function_rights_connection[$row["function_name"]] = $row;
        }



        $sql = "select *"
            .",(SELECT COUNT(*)> 0 FROM __definition_tableconfig where function_name = __definition_function.function_name AND is_quicksearch = 1) as allowQuicksearch"
            ." ,(SELECT count(*) FROM __definition_additional_data where __definition_additional_data.function_name = __definition_function.function_name)>0 as DoLoadAdditionalData"
            ." from __definition_function WHERE deactivated = 0";
        $data=$db->getData($sql);

        foreach($data as $row){
            $definitions_functions[$row["function_name"]] = $row;
        }

        $sql = "select * from __definition_tableconfig ORDER BY function_name, sortorder";
        $data=$db->getData($sql);

        foreach($data as $row){
            if(!isset($definitions_tableconfigs[$row["function_name"]])){
                $definitions_tableconfigs[$row["function_name"]] = [];
            }
            $definitions_tableconfigs[$row["function_name"]][] = $row;
        }

        $sql = "SELECT * FROM __definition_formconfig ORDER BY function_name, form_group, sortorder";
        $data=$db->getData($sql);

        foreach($data as $row){
            
            $allowed = checkIfUserHasRight($row["right_function_name"], $row["right_sub_function"]);

            if($allowed){
                if(!isset($definitions_formconfigs[$row["function_name"]])){
                    $definitions_formconfigs[$row["function_name"]] = [];
                }
                $definitions_formconfigs[$row["function_name"]][] = $row;
            }   
        }

        $sql = "SELECT * FROM __definition_function_buttons ORDER BY function_name";
        $data=$db->getData($sql);

        foreach($data as $row){

            if(checkIfUserHasRight($row["right_function_name"], $row["right_sub_function"])){
                if(!isset($definitions_functionbuttons[$row["function_name"]])){
                    $definitions_functionbuttons[$row["function_name"]] = [];
                }
                $definitions_functionbuttons[$row["function_name"]][$row["button"]] = $row;
            }
        }

        $sql = "SELECT * FROM __definition_extrabuttons  where deactivated = 0 ORDER BY function_name, sortorder";
        $data=$db->getData($sql);

        foreach($data as $row){

            if(checkIfUserHasRight($row["right_function_name"], $row["right_sub_function"])){
                if(!isset($definitions_extraButtons[$row["function_name"]])){
                    $definitions_extraButtons[$row["function_name"]] = [];
                }
                $definitions_extraButtons[$row["function_name"]][] = $row;
            }
        }

        $navbar_items=[];

        $sql = " "
            ." SELECT * FROM _navbar_groups"
    
            ." where visible = 1"
            ." ORDER BY sortorder";
        $tmp = $db->getData($sql);

        $navgroups = [];
        foreach($tmp as $item){
            $navgroups[$item["id"]] = $item;
            $navgroups[$item["id"]]["subitems"] = [];
        }

        $sql = "select * from _navbar where `visible` = 1 order by navbar_group,sorting";
        $navbar_subitems = $db->getData($sql);

        foreach($navbar_subitems as $item){
            if(isset($navgroups[$item["navbar_group"]])){
                $doShow = true;
                $nav_rights = getRightsForDefinedFunction($item["name"]);

                $nav_allowed = checkIfUserHasRight($nav_rights["right_function_name"], $nav_rights["right_sub_function"]);

                if($nav_allowed){
                    $navgroups[$item["navbar_group"]]["subitems"][] = $item;
                }
            }
        }

        foreach($navgroups as $item){
            if(count($item["subitems"])>0){
                $navbar_items[] = $item;
            }
        }
        


        $db->close();
    }

    


    function getRightsForDefinedFunction($functionname){
        global $function_rights_connection;
        $retval = [
            "function_name" => $functionname
            ,"right_function_name" => ""
            ,"right_sub_function" => ""  
        ];
        if(isset($function_rights_connection[$functionname])){
            $retval = $function_rights_connection[$functionname];
        }
        return $retval;
    }


    function checkIfUserHasRight($functionname, $subfuntion){
        global $rights;

        $success = true;
        if($functionname != "" && $subfuntion != ""){
            if(isset($rights[$functionname][$subfuntion])){
                $success = $rights[$functionname][$subfuntion];
            }
            else{
                $success = false;
            }
        }
        return $success;
    }


    function getFunctionConfig($page_name){
        global $definitions_functions;
        $returnvalue = "";

        if(isset($definitions_functions[$page_name])){
            $returnvalue = json_encode($definitions_functions[$page_name]);
        }

        return $returnvalue;
    }

    function getFunctionButtonConfig($page_name){
        global $definitions_functionbuttons;
        $returnvalue = "{}";

        if(isset($definitions_functionbuttons[$page_name])){
            $returnvalue = json_encode($definitions_functionbuttons[$page_name]);
        }

        return $returnvalue;
    }

    function getTableConfig($page_name){
        global $definitions_tableconfigs;
        $returnvalue = "";

        if(isset($definitions_tableconfigs[$page_name])){
            $returnvalue = json_encode($definitions_tableconfigs[$page_name]);
        }

        return $returnvalue;
    }

    function getFormsConfig($page_name){
        global $definitions_formconfigs;
        $returnvalue = "";

        if(isset($definitions_formconfigs[$page_name])){
            $returnvalue = json_encode($definitions_formconfigs[$page_name]);
        }

        return $returnvalue;
    }

    function getExtraButtonsConfig($page_name){
        global $definitions_extraButtons;
        $returnvalue = "";

        if(isset($definitions_extraButtons[$page_name])){
            $returnvalue = json_encode($definitions_extraButtons[$page_name]);
        }

        return $returnvalue;
    }


    function getTranslation($programmtype, $keyword){
        global $translations;
        $retval = $keyword;
        $retval = $keyword;

        $translationAvailable = false;

        if(isset($translations[$programmtype])){
            if(isset($translations[$programmtype][$keyword])){
                if($translations[$programmtype][$keyword] !== ""){
                    $retval = $translations[$programmtype][$keyword];
                    $translationAvailable=true;
                }
            }
            
        }

        if(!$translationAvailable){
            //echo "translations[".$programmtype."][".$keyword."] is undefined";
        }

        return $retval;
    }

    function getComboboxFields($page,$locale){
        global $locale;
        global $database;

        
        $db = new Database($database);
        $dropDownConfig = [];

        if($db){
            $formConfigs = getFormsConfig($page);
            if($formConfigs != "" && $formConfigs!= "[]"){
                $formCfg = json_decode($formConfigs,true);
    
                $columns = [];
    
                foreach($formCfg as $row){
                    $columns[] = "'".$row["columnname"]."'";
                }
    
                $cols = implode(",",$columns);
    
                $sql = " "
                    ." select * from __definition_dropdowns"
                    ." where `column_name` in (".$cols.")";
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

            $db->close();
        }

        



        return json_encode($dropDownConfig);


    }


?>