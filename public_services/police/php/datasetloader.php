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
    
    $fields = [];

    $paramError = false;

    $page = 1;
    $quicksearch = "";
    $id = -1;

    

    if(isset($_POST["page"])){
        $page = $_POST["page"];
    }
    if(isset($_POST["id"])){
        $id = $_POST["id"];
    }
    if(isset($_POST["quicksearch"])){
        $quicksearch = $_POST["quicksearch"];
    }
    if(isset($_POST["function"])){
        $function = $_POST["function"];
    }
    else{
        $msg = ($msg == "" ? "" : "<br>") . "param <strong>function</strong> is missing!";
        $paramError=true;
    }

    

    $page = $page -1;

    $totalRowCount = 0;

    


    if(!$paramError){

        if($function !== ""){
            $db = new Database($database);
            if($db){

                if($function == "archive"){
                    $sql = "select *"
                    ." ,ifnull((select translation from __definition_languages_values where __definition_languages_values.locale = '".$locale."' and __definition_languages_values.programmtype = __archive_settings.translation_programmtype and __definition_languages_values.keyvalue = __archive_settings.translation_key),mysql_table) as `Type`"
                    ." from __archive_settings where deactivated = 0 order by sortorder";

                    $data=$db->getData($sql);

                    $columns = ["Type","Count", "uid"];

                    foreach($data as $index => $line){
                        $sql = "select count(*) as cnt FROM ".$line["mysql_table"]." where ".$line["deleted_column"] . " =  1 and hide_in_archiv = 0";
                        $tempdata=$db->getData($sql);

                        if(count($tempdata)>0){
                            $data[$index]["Count"] = $tempdata[0]["cnt"];
                        }   
                    }
                    foreach($data as $index => $line){
                        foreach($columns as $fd){
                            $valueArray[$index][] = ["id" => $fd, "value" => $line[$fd]];
                        }
                    }

                }
                else if($function == "archive_details"){

                    $sql = "SELECT * FROM __archive_columns_to_show";
                    $data=$db->getData($sql);

                    $displayColumns=[];

                    foreach($data as $line){
                        $displayColumns[$line["columname"]] = 1;
                    }

                    
                    $sql = "select * from __archive_settings where uid = ".$id;
                    $maindata=$db->getData($sql);

                    if(count($maindata)>0){
                        $columns=["changeddate","values","uid"];

                        $sql = "select *,".$maindata[0]["uniquecol"] ." as uid" ." from ".$maindata[0]["mysql_table"]." where ".$maindata[0]["deleted_column"] . " =  1 and hide_in_archiv = 0 order by changeddate desc";

                        $data=$db->getData($sql);

                        foreach($data as $index => $line){
                            foreach($columns as $col){
                                if($col == "values"){
                                    $temp="";
                                    foreach($line as $colName => $colValue){
                                        if(isset($displayColumns[$colName])){

                                            

                                            $temp.=($temp == "" ? "" : "<br>") . "<strong>".getTranslation("columns", $colName) ."</strong>: ".$colValue;
                                        }
                                    }

                                    $valueArray[$index][] = ["id" => $col, "value" => $temp];

                                }
                                else if($col == "changeddate"){
                                    $valueArray[$index][] = ["id" => $col, "value" => date('d.m.Y H:i:s',strtotime($line[$col]))];
                                }
                                else if($col == "uid"){
                                    $valueArray[$index][] = ["id" => $col, "value" => $maindata[0]["mysql_table"]."|".$maindata[0]["uniquecol"]."|".$maindata[0]["deleted_column"]."|".$line[$col]];
                                }
                            }
                        }


                    }

                }
                else{
                    $extraSelect = getExtraSelect($db ,$function);
                    $fixedQuery = getFixedQueries($db ,$function);
    
                    //return ["sql" => $sql,  "columns" => $column_names, "doExecDefaultQuery" => $execQuery];
    
                    $sqlMain = "";
    
    
                    $functionConfig = getFunctionConfig($function);
                    $formConfig = getFormsConfig($function);
                    $tableConfig = getTableConfig($function);
    
    
    
                    if($functionConfig !== "" && $functionConfig !== "[]"){
                        $functionConfig = json_decode($functionConfig,true);
                        $needsCount = $functionConfig["needsCount"];
                        
                        $extraWhereStatement = $functionConfig["extraWhereStatement"];
                        $orderBy = $functionConfig["orderBy"];
                        $mysqlTable = $functionConfig["mysql_table"];
                        $needsCount = $functionConfig["needsCount"];
    
                        if($functionConfig["doLoadData_UseridAsId"] == 1){
                            $id = $_SESSION["userid"];
                        }
    
                        
                        $sqlReplaceFrom = ["@@USERID@@","@@ID@@",'@@LOCALE@@'];
                        $sqlReplaceTo = [$_SESSION["userid"],$id, $locale];
    
                        $extraSelect = str_replace($sqlReplaceFrom, $sqlReplaceTo, $extraSelect);
    
    
                        $columns=[];
                        $whereColumns = [];
                        $limit = "";
    
                        if($functionConfig["type"] == "table"){
                            $tableConfig = json_decode($tableConfig,true);
                            $limit = " limit ".($page*$limitPerPage).",".(($page+1)*$limitPerPage);
                            foreach($tableConfig as $col){
                                $columns[] = $col["columnname"];
                                if($col["is_quicksearch"] == 1){
                                    $whereColumns[] = $col["columnname"];
                                }
                            }
                        }
    
                    
    
                        //wenn es eine fixierte query ist
                        if($fixedQuery["sql"] !== "" && $fixedQuery["doExecDefaultQuery"] === false){
                            $extraSelect = $fixedQuery["columns"];
                            $sqlMain = $fixedQuery["sql"];
                            $allowSearch = $fixedQuery["allowSearch"];
    
                            
                            
                            $whereStatement = "";
                            if($allowSearch == 1){
                                if($functionConfig["type"] == "table"){
                                    $whereStatement = getQuickSearch($db, $quicksearch, $whereColumns, $whereStatement);
                                }
                            }
    
                            $sqlMain = str_replace("@@WHERE@@", $whereStatement, $sqlMain);
    
                            
                            $sqlMain = str_replace($sqlReplaceFrom, $sqlReplaceTo, $sqlMain);
    
    
    
                            execQuery($sqlMain, $extraSelect, $orderBy, $needsCount, $columns);
                        }
                        //wenn es keine fixierte query ist
                        else{
                            $execSqlQuery = true;
                            $success = true;
                            
                            if($functionConfig["type"] == "table"){
                                if(count($columns) > 0){
                                    $whereStatement = "";
                                    if(trim($extraWhereStatement) != ""){
                                        $whereStatement.=" ".str_replace($sqlReplaceFrom,$sqlReplaceTo,$extraWhereStatement)." ";
                                    }
    
                                    $whereStatement = getQuickSearch($db, $quicksearch, $whereColumns, $whereStatement);
    
                                    /*create mysql queries*/ 
                                    $sqlMain = " "
                                        ." SELECT"
                                            ."@@columns@@"
                                        ." FROM ".$mysqlTable
                                        .$whereStatement
                                        ." @@ORDERBY@@"
                                        ." @@LIMIT@@"
                                        ;
    
                                    execQuery($sqlMain, $extraSelect, $orderBy, $needsCount,$columns);
                                }
    
                            }
                            else if($functionConfig["type"] == "form"){
                                if(is_numeric($id) && $id > -1){
                                    $uniquecolumn = $functionConfig["uniquecol"];
                                    $mysqlTable = $functionConfig["mysql_table"];
    
                                    
                                    $whereStatement = "";
                                    if(trim($extraWhereStatement) != ""){
                                        $whereStatement.=" ".str_replace($sqlReplaceFrom,$sqlReplaceTo,$extraWhereStatement)." ";
                                    }
    
                                    $whereStatement.=($whereStatement == "" ? " WHERE ": " AND ").$uniquecolumn." = ".$id;
            
                                    
                                    $formConfig = json_decode($formConfig,true);
            
                                    $sql = "SELECT *".$extraSelect." FROM ".$mysqlTable." ".$whereStatement;
    
                                    $data= $db -> getData($sql);
    
                                    if(count($data)>0){
    
                                        $index = 0;
    
                                        foreach($formConfig as $form){
                                            $columnname = $form["columnname"];
    
                                            if($columnname == "reason_of_is_wanted"){
                                                
                                                $valueArray[$index] = [];
                                                $valueArray[$index]["name"] = "id_".$columnname;
                                                $valueArray[$index]["value"] = $data[0]["reason_of_is_wanted"];
                                                $valueArray[$index]["display"] = ($data[0]["is_wanted"] == 1 ? "":"none");
    
                                            }
                                            else{
                                                $valueArray[$index] = [];
                                                $valueArray[$index]["name"] = "id_".$columnname;;
                                                $valueArray[$index]["value"] = $data[0][$columnname];
                                            }
                                            $index++;
                                        }
                                    }
                                }
                            }
                        }
                    }
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
        ,"values" => $valueArray
        ,"totalRows" => $totalRowCount
        ,"msg" => $msg
    ];

    echo json_encode($retArray);

    function getQuickSearch($db, $quicksearch, $whereColumns, $currentWhereStatement){
    
        $whereStatement = $currentWhereStatement;
        if(trim($quicksearch) != ""){
            $doClose = false;

            if($whereStatement != ""){
                $whereStatement.= " AND (";
                $doClose=true;
            }
            else{
                $whereStatement .= " WHERE ";
            }

            $temp = "";

            $quicksearch = strtolower($quicksearch);
            foreach($whereColumns as $col){
                $temp .= ($temp == "" ? "" : " OR ") ."LOWER(". $col.") like '%".$db->escapeString($quicksearch)."%'";
            }

            $whereStatement.=$temp;

            if($doClose){
                $whereStatement.=" ) ";
            }
        }
        return $whereStatement;
    }

    function getFixedQueries($db ,$function){
        global $sqlReplaceFrom;
        global $sqlReplaceTo;

        $sql = "";
        $column_names = "";
        $execQuery = true;
        $allowSearch = false;

        $sql = "SELECT * FROM __definition_fixed_sqlquery WHERE function_name = '".$db->escapeString($function)."'";
        $data=$db->getData($sql);

        if(count($data)>0){
            $sql = str_replace($sqlReplaceFrom, $sqlReplaceTo, $data[0]["sql_query"]);
            $column_names = str_replace($sqlReplaceFrom, $sqlReplaceTo, $data[0]["column_names"]);
            $execQuery = false;
            $allowSearch = $data[0]["allowSearch"];
        }

        return ["sql" => $sql, "allowSearch"=> $allowSearch, "columns" => $column_names, "doExecDefaultQuery" => $execQuery];
    }

    function execQuery($sqlMain, $extraSelect, $orderBy, $needsCount, $columns){
        global $db;
        global $valueArray;
        global $totalRowCount;
        global $page;
        global $limitPerPage;


        //get data statement
        $replaceFrom = [
            "@@columns@@"
            ,"@@ORDERBY@@"
            ,"@@LIMIT@@"
        ];
        $replacements=[
            " *".$extraSelect
            ,(trim($orderBy) != "" ? " ORDER BY ".$db->escapeString($orderBy) : "")
            ,($needsCount == 1 ? " limit ".$db->escapeString(($page*$limitPerPage)).",".$db->escapeString((($page+1)*$limitPerPage)) : "")
        ];
        $sqlData = str_replace($replaceFrom, $replacements, $sqlMain);

        $dataMain=$db->getData($sqlData);

        foreach($dataMain as $index => $line){
            foreach($columns as $fd){
                $valueArray[$index][] = ["id" => $fd, "value" => $line[$fd]];
            }
        }

        if($needsCount == 1){
            $replacements=[
                " COUNT(*) as _cnt"
                ,""
                ,""
            ];

            $sqlCount = str_replace($replaceFrom, $replacements, $sqlMain);
            $dataCount=$db->getData($sqlCount);
            if(count($dataCount) > 0){
                $totalRowCount = $dataCount[0]["_cnt"];
            }
        }
    }

    function getExtraSelect($db, $function){
        global $sqlReplaceFrom;
        global $sqlReplaceTo;

        $retval = "";
        $sql = "SELECT * FROM __definition_function_extra_selects WHERE function_name = '".$db->escapeString($function)."'";
        $data=$db->getData($sql);

        if(count($data)>0){
            $retval = str_replace($sqlReplaceFrom, $sqlReplaceTo, $data[0]["extra_select"]);
        }


        return $retval;
    }
?>