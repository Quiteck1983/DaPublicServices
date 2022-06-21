<?php

    ini_set('session.cookie_samesite', 'None');
    ini_set('session.cookie_secure', 'true');
    session_start();

    
    require_once("./../../global/php/database/database.php");
    require_once("./../configs/config_db.php");    
    require_once("./../../global/config.php");    
    require_once("./../configs/config.php");    
    require_once("./../configs/startup_config.php");  
    require_once("./../php/cookie.php");    

    
    $_SESSION=[];
    unset($_SESSION);
    session_destroy();

    deleteCookie();

    

    header("Location:".$serverAddress."login/");
?>