<?php
    session_start();
    $_SESSION=[];
    unset($_SESSION);
    session_destroy();
?>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Public service</title>
        <link rel="stylesheet" href="./global/bootstrap/materia/bootstrap.min.css"/>
        <link rel="stylesheet" href="./global/bootstrap/bootstrap.min.css"/>

        <script src="./global/js/jquery/jquery.js"></script>
        <script src="./global/bootstrap/js/bootstrap.min.js"></script>
    </head>

    <body>
        <div class="container">
                <h1 id = "pagertitle">
                    Welcome to the Public Services Overview!
                </h1>
                <div id = "id_content">
                    <button type="button" class="btn btn-lg btn-primary btn-block" onclick = "doChangePage('police')">Go to Police Network</button>
                    <button type="button" class="btn btn-lg btn-info btn-block" onclick = "doChangePage('medic')">Go to Medic Network</button>
                    
                </div>
            </div>
        </div>
    </body>
    <script>
        function doChangePage(page){
            window.location.href = window.location.href.replace("start.php",page+"/")
        }
    </script>
</html>