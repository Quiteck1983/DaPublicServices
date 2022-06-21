<?php    
    ini_set('session.cookie_samesite', 'None');
    ini_set('session.cookie_secure', 'true');
    session_start();

    require_once("./../../global/php/database/database.php");
    require_once("./../configs/config.php");    
    require_once("./../configs/config_db.php");    
    require_once("./../configs/job_config.php");    
    require_once("./../php/cookie.php");    



    $username = "";
    $pwd = "";
    if(isset($_POST["user"])){
        $username = $_POST["user"];
    }
    if(isset($_POST["password"])){
        $pwd = $_POST["password"];
    }

    $db = new database($database);

    $success = false;
    $msg = "";
    if($db){

        $username = $db->escapeString($username);
        $pwd = md5($db->escapeString($pwd));

        $sql = "SELECT * FROM registered_user"

            ." where LOWER(loginname) = '".strtolower($username)."'"
                ." and password = '".$pwd."'"
                ." and deleted = 0"
                ." and suspended = 0";

                

        $data = $db->getData($sql);
        if(count($data)>0){
            $success = true;

            $_SESSION["userid"] = $data[0]["userid"];
            $_SESSION["loginname"] = $data[0]["loginname"];
            $_SESSION["first_name"] = $data[0]["first_name"];
            $_SESSION["last_name"] = $data[0]["last_name"];
            $_SESSION["locale"] = $data[0]["locale"];
            $_SESSION["jobtype"] = $requiredJobname;

            rememberLogin($data[0]["loginname"]);
        }
        else{
            $msg = "Wrong user or password!";
        }
    }
    else{
        $msg = "no database connection!";
    }

    $retval = [
        "success" => ($success?1:0)
        ,"msg" => $msg
    ];
    echo json_encode($retval);
    
?>