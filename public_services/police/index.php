<?php

    ini_set('session.cookie_samesite', 'None');
    ini_set('session.cookie_secure', 'true');
    session_start();
  
    require_once("./configs/config_db.php");  
    require_once("./php/cookie.php");    
    require_once("./configs/job_config.php");    
    require_once("./../global/php/database/database.php");   
    require_once("./configs/config.php");    

    if(!isset($_SESSION["userid"])){
        checkForUserLogin();
    }

    require_once("./../global/config.php");  
    require_once("./configs/job_config.php");      
    require_once("./configs/startup_config.php");    
    require_once("./configs/config_password.php");  



    


    $defaulttype = "dashboard";
    $type = "dashboard";


    $id = -1;

    if(isset($_GET["i"])){
        $type = $_GET["i"];
    }

    if(isset($_GET["id"])){
        $id = $_GET["id"];
    }

    $pageAllowed = true;


    
    $page_rights = getRightsForDefinedFunction($type);
    $pageAllowed = checkIfUserHasRight($page_rights["right_function_name"], $page_rights["right_sub_function"]);

    if(!$pageAllowed){
        header("Location:".$serverAddress);
    }

    


    if(isset($_SESSION["userid"])){
        if($_SESSION["userid"] != ""){

            

            if($_SESSION["jobtype"] != $requiredJobname){

                unset($_SESSION);
                setcookie("auto", "");
                header("Location:".$serverAddress."login/");
                exit();
            }
            else{
                $user_loggedin = true;
            }
        }
    }
    if(!$user_loggedin){
        header("Location:".$serverAddress."login/");
        exit();
    }    

?>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Cops - <?php echo $servername; ?></title>
        <link rel="stylesheet" href="./../global/bootstrap/materia/bootstrap.min.css"/>
        <link rel="stylesheet" href="./../global/bootstrap/bootstrap.min.css"/>

        <link rel="stylesheet" href="./../global/css/navbar-fixed-left.min.css">
        <link rel="stylesheet" href="./../global/css/docs.css">
        <link rel="stylesheet" href="./css/doc.css">
        <script src="./../global/js/jquery/jquery.js"></script>
        <script src="./../global/bootstrap/js/bootstrap.min.js"></script>


        <script src="./../global/js/original_source/functions.js"></script>
        <script src="./../global/js/original_source/renderer.js"></script>
        <script src="./../global/js/original_source/additionalData.js"></script>
        <script src="./../global/js/original_source/Forms.js"></script>
        <script src="./../global/js/original_source/dataloader.js"></script>
        
        <script src="./../global/js/original_source/pageLoader.js"></script>
        <script src="./js/original_source/additionalData.js"></script>
        <script src="./js/original_source/datasaver_custom.js"></script>
        <script src="./js/original_source/renderer.js"></script>



        <script src="./../global/js/Framework/DaBurnerGermany.js"></script>
        <script src="./../global/js/Framework/Buttons.js"></script>
        <script src="./../global/js/Framework/FieldSet.js"></script>
        <script src="./../global/js/Framework/TextArea.js"></script>
        <script src="./../global/js/Framework/PortalRow.js"></script>
        <script src="./../global/js/Framework/TextField.js"></script>
        <script src="./../global/js/Framework/NumberField.js"></script>
        <script src="./../global/js/Framework/DateField.js"></script>
        <script src="./../global/js/Framework/DropDown.js"></script>
        <script src="./../global/js/Framework/FormGroup.js"></script>
        <script src="./../global/js/Framework/FormRow.js"></script>
        <script src="./../global/js/Framework/Grid.js"></script>
        <script src="./../global/js/Framework/FieldLabel.js"></script>
    </head>

    <body class = "container-noscroll">
        
        <nav class="navbar navbar-expand-md navbar-dark bg-dark fixed-left navbar-nopadding navbar-scroll">
            <a class="navbar-brand navbar-brand-nopadding bg-dark navbar-branding" id = "home" href ><?php echo $_SESSION["first_name"]." ".$_SESSION["last_name"]; ?></a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault"
                    aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarsExampleDefault">
                <ul class="navbar-nav">
                    <?php 
                    
                    foreach($navbar_items as $item){

                        echo '<li class = "nav-item">'
                            .'<a class = "navbar-link-header">'.getTranslation("global",$item["id"]).'</a>'
                            .'</li>';
                        

                        foreach($item["subitems"] as $subitem){
                            echo '<li class = "nav-item subitem">'
                            .'<span class="nav-link navhover" id = "navbar_'.$subitem["name"].'" onclick = "doLoadPageContent(\'' . $subitem["goto_function_name"] . '\',\'' . $subitem["goto_sub_function_name"] . '\',-1)">'.getTranslation("pageloader",$subitem["translation_key"]).'</a>'
                            .'</li>';
                        }
                    }
                    
                            
                    ?>

                    <li class = "nav-item">
                        <a class = "navbar-link-header"></a>
                    </li>
                    <li class = "nav-item">
                        <a class = "navbar-link-header"></a>
                    </li>
                    <li>
                        <a class="nav-link btn-danger"  id = "logout" href="<?php $serverAddress?>logout/logout.php">Logout</a>
                    </li>
                </ul>
            </div>
        </nav>


        <div class="container">
                <h1 id = "pagertitle">
                    
                </h1>                
                <div id = "loadingbar" class="d-flex justify-content-center">
                    
                </div>

                <div class="alert alert-warning" role="alert" style="display:none" id = "id_alert">
                    This is a warning alert—check it out!
                </div>

                <div class="alert alert-primary" role="alert" style="display:none" id = "id_alertinfo">
                    This is a warning alert—check it out!
                </div>

                <div id = "id_content">
                    
                </div>


                


            </div>
        </div>
    </body>

    <script>

        const serveraddress = '<?php echo $serverAddress?>';

        
        const passwordRegex = new RegExp('<?php echo getPasswordRegex(); ?>');
        const passwordConfig = JSON.parse('<?php echo json_encode($config_password); ?>');
        

    
        var dropDownConfig = [];
        const UserRights = JSON.parse('<?php echo json_encode($rights);?>');
        const FunctionToRights = JSON.parse('<?php echo json_encode($function_rights_connection);?>')
        const Translations = JSON.parse('<?php echo json_encode($translations) ?>');
    

        var totalRowsForQuery = 0;

        $(document).ready(function () {

            //DaBurnerGermany.setTitle(getWord("global",currenttype));

            //loadContent(currenttype);

            doLoadPageContent("dashboard","",-1);



        });
        

        
    </script>

</html>