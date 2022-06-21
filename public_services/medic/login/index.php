<?php

    ini_set('session.cookie_samesite', 'None');
    ini_set('session.cookie_secure', 'true');

    session_start();

    require_once("./../../global/php/database/database.php");
    require_once("./../configs/config_db.php");    
    require_once("./../../global/config.php");    
    require_once("./../configs/config.php");    
    require_once("./../configs/startup_config.php");  

    $user_loggedin = false;
    $locale = 'en';

    if(isset($_SESSION["user_id"])){
        if($_SESSION["user_id"] != ""){
            $user_loggedin = true;
        }
    }

    if($user_loggedin){
        header("Location:".$serverAddress);
    }
?>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Medics - <?php echo $servername; ?></title>
        <link rel="stylesheet" href="./../../global/bootstrap/materia/bootstrap.min.css"/>
        <link rel="stylesheet" href="./../../global/bootstrap/bootstrap.min.css"/>

        <link rel="stylesheet" href="./../../global/css/navbar-fixed-left.min.css">
        <link rel="stylesheet" href="./../../global/css/docs.css">
        <script src="./../../global/js/jquery/jquery.js"></script>
        <!--<script src="../js/jquery/jquery-3.4.1.slim.min.js"></script>-->
        <script src="./../bootstrap/js/bootstrap.min.js"></script>
        <script src="./../../global/js/original_source/functions.js"></script>

    </head>

    <body>
        

        <div style="margin-top:30px;" class="container">
        
            <h1 id = "pagertitle">
                <?php echo $servername; ?> - Medics
            </h1>
            <div id = "id_content">                        
                <div class="avatar">
                    <img class="avatar_img" src = "./../gfx/logo.png">
                </div>
                <h4>
                    Login to your account.
                </h4>
                <div class="alert alert-warning" role="alert" style="display:none" id = "id_alert">
                    This is a warning alert—check it out!
                </div>
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" class="form-control" id="username" aria-describedby="emailHelp" placeholder="Enter username">
                    <small id="emailHelp" class="form-text text-muted">We'll never share your username with anyone else.</small>
                </div>
                <div class="form-group">
                    <label for="id_pwd">Password</label>
                    <input type="password" class="form-control" id="id_pwd" placeholder="Enter Password">
                </div>
                <button type="button" class="btn btn-primary btn-block" onclick="login()">Login</button>
            </div>
        </div>
    </body>
    <script>
        function login(){
            let alertel = document.getElementById("id_alert");
            $.ajax({
            type: "POST",
            data:{
                "user" : $("#username")[0].value
                ,"password" : $("#id_pwd")[0].value
            },
            url: "./login.php",
            success: function(response){
                let json = JSON.parse(response);

                if(json.success){
                    window.location.href = "<?php echo $serverAddress; ?>";
                }
                else{
                    alertel.innerHTML = json.msg;
                    alertel.style.display = "";
                    $("#id_pwd")[0].value="";
                }                
            },
            failure:function(){
                alertel.innerHTML = "Server Error";
                alertel.style.display = "";
            }
        });
        }

        $(document).ready(function () {
            $('#username').focus(); 
        });

        $("#username").keypress(function(event) {
            if (event.keyCode === 13) {
                login();
            }
        });
        $("#id_pwd").keypress(function(event) {
            if (event.keyCode === 13) {
                login();
            }
        });

    </script>
</html>