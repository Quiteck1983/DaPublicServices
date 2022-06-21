<?php
    
    require_once("./global/files_cfg.php");
    require_once("./global/startup_check.php");

    $databaseFileDone = !checkIfDatabaseIsConfigured(true);
    $configFileDone = !checkIfSoftwareIsConfigured(true);

    $CopDBReady = checkIfDatabaseCreated("police");
    $medicDBReady = checkIfDatabaseCreated("medic");   
	

    if($databaseFileDone==1 && $configFileDone ==1 && $CopDBReady==1 && $medicDBReady == 1){   
        header("Location:./start.php");
    }
        

?>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Public Services-Config</title>
        <link rel="stylesheet" href="./global/bootstrap/materia/bootstrap.min.css"/>
        <link rel="stylesheet" href="./global/bootstrap/bootstrap.min.css"/>

        
        
        <script src="./global/js/jquery/jquery.js"></script>
        <script src="./install/js/main.js"></script>
        
        <script src="./global/bootstrap/js/bootstrap.min.js"></script>
    </head>

    <body>
        

        <div style="margin-top:30px;" class="container">
        
            <h1 id = "pagertitle">
                Server configuration
            </h1>
            <div id = "id_content">      
                
                
            </div>
        </div>
        <script>

            $(document).ready(function () {
                getPageContent(<?php echo ($databaseFileDone ? 1:0); ?>, <?php echo ($configFileDone ? 1:0) ; ?>, <?php echo ($CopDBReady && $medicDBReady ? 1 : 0) ; ?>);
            });



        </script>
    </body>
</html>