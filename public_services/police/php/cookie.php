<?php    



function checkForUserLogin(){
    global $requiredJobname;
    global $database;
    global $serverAddress;

    $db = new database($database);

    $retval = false;

    if($db){
        $rememberMe = new RememberMe($requiredJobname, $serverAddress);
        $data = $rememberMe->auth($db);

        if($data){
            foreach($data as $key => $value){
                $_SESSION[$key] = $value;
            }
            $retval = true;
        }
        $db -> close();
    }
    return $retval;
}

function rememberLogin($loginname){ 
    global $requiredJobname;
    global $database;
    global $serverAddress;

    $db = new database($database);

    if($db){
        $rememberMe = new RememberMe($requiredJobname, $serverAddress);
        $rememberMe -> remember($db,$loginname);
        $db -> close();
    }
}

function deleteCookie(){ 
    global $requiredJobname;
    global $database;
    global $serverAddress;
    $db = new database($database);

    if($db){


        $rememberMe = new RememberMe($requiredJobname, $serverAddress);
        $rememberMe -> logout($db);
        $db -> close();
    }
}







class RememberMe {
    private $key = "6f2e160d46d93ad8a96495c285a9762e9b3ed88f73be2feb94180024c326b7de";
    private $cookieDuration =  7 *24*3600; //7 Tage
    private $JobName = "";
    private $servername = "";

    function __construct($job, $path) {
        $this->JobName = $job;

        $http = 'http://';
        if(isset($_SERVER["HTTPS"])){
            $http = 'https://';
        }
        $serverAddressRoot = $http.$_SERVER["SERVER_NAME"];


        //$this->servername = $path;
        $this->servername = str_replace($serverAddressRoot,"",$path);
        
    }

    public function auth($db) {
        

        // Check if remeber me cookie is present
        if (! isset($_COOKIE["auto"]) || empty($_COOKIE["auto"])) {
            return false;
        }

        // Decode cookie value
        if (! $cookie = @json_decode($_COOKIE["auto"], true)) {
            return false;
        }

        // Check all parameters
        if (! (isset($cookie['user']) || isset($cookie['token']) || isset($cookie['signature'])  || isset($cookie['jobtype']))) {
            return false;
        }

        if($cookie['jobtype'] != $this->JobName){
            return false;

        }

        $var = $cookie['user'] . $cookie['token'] . $cookie['jobtype'];



        // Check Signature
        if (! $this->verify($var, $cookie['signature'])) {
            return false;
        }

        // Check Database

        $sql = "SELECT * FROM registered_user where MD5(LOWER(loginname)) = '".$cookie["user"]."' AND deleted = 0 and suspended = 0";
        $data=$db->getData($sql);


        $cookieSetting="";

        if (empty($data)){
            throw new Exception("Data empty");
            
            return false; // User must have deleted accout
        }
        else{
            $cookieSetting = $data[0]["cookie_setting"];
        }

        // Check User Data
        if (! $cookieSetting = json_decode($cookieSetting, true)) {
            return false;
        }

        // Verify Token
        if ($cookieSetting['token'] !== $cookie['token']) {

            return false;
        }

        /**
         * Important
         * To make sure the cookie is always change
         * reset the Token information
         */

        $info = [
            "userid" => $data[0]["userid"]
            ,"loginname" => $data[0]["loginname"]
            ,"first_name" => $data[0]["first_name"]
            ,"last_name" => $data[0]["last_name"]
            ,"locale" => $data[0]["locale"]
            ,"jobtype" => $this->JobName
        ];

        $this->remember($db, $data[0]["loginname"]);
        return $info;
    }

    public function remember($db, $user) {

        $user = md5(strtolower($user));



     
        $cookie = [
                "user" => $user,
                "token" => $this->getRand(64),
                "signature" => null,
                "jobtype" => $this->JobName
        ];
        $cookie['signature'] = $this->hash($cookie['user'] . $cookie['token'] . $cookie["jobtype"]);
        $encoded = json_encode($cookie);

        // Add User to database
        $success = $db->execute("update registered_user set cookie_setting='".$db->escapeString($encoded)."' where MD5(LOWER(loginname)) = '".$user."'");

        
        if(!$success){
            $db->rollback();
        }
        else{
            $db->commit();
        }

        /**
         * Set Cookies
         * In production enviroment Use
         * setcookie("auto", $encoded, time() + $expiration, "/~root/",
         * "example.com", 1, 1);
         */
        //setcookie("auto", $encoded); // Sample
        
        setcookie("auto", $encoded, time() + $this->cookieDuration,$this->servername);
        //setcookie("path", $this->servername, time() + $this->cookieDuration,'/');
        //setcookie("auto", $encoded, time() + $this->cookieDuration, $this->servername,$_SERVER["REMOTE_ADDR"],false,false);
    }

    public function logout($db) {

        if(isset($_COOKIE["auto"])){
            $cookie = json_decode($_COOKIE["auto"],true);

            if(isset($cookie["user"])){
                $cookie = json_decode($_COOKIE["auto"],true);
                $success = $db->execute("update registered_user set cookie_setting='".json_encode([])."' where MD5(LOWER(loginname)) = '".$cookie["user"]."'");
    
            
                if(!$success){
                    $db->rollback();
                }
                else{
                    $db->commit();
                }
            }
            setcookie("auto", json_encode([]), time() + $this->cookieDuration,$this->servername);
            //setcookie("auto", json_encode([]), time() + $this->cookieDuration, $this->servername,$_SERVER["REMOTE_ADDR"],false,false);
        }

        
        


        // Add User to database
        

        /**
         * Set Cookies
         * In production enviroment Use
         * setcookie("auto", $encoded, time() + $expiration, "/~root/",
         * "example.com", 1, 1);
         */
        //setcookie("auto", $encoded); // Sample
        
    }

    public function verify($data, $hash) {
        $rand = substr($hash, 0, 4);
        return $this->hash($data, $rand) === $hash;
    }

    private function hash($value, $rand = null) {
        $rand = $rand === null ? $this->getRand(4) : $rand;
        return $rand . bin2hex(hash_hmac('sha256', $value . $rand, $this->key, true));
    }

    private function getRand($length) {
        switch (true) {
            case function_exists("mcrypt_create_iv") :
                $r = mcrypt_create_iv($length, MCRYPT_DEV_URANDOM);
                break;
            case function_exists("openssl_random_pseudo_bytes") :
                $r = openssl_random_pseudo_bytes($length);
                break;
            case is_readable('/dev/urandom') : // deceze
                $r = file_get_contents('/dev/urandom', false, null, 0, $length);
                break;
            default :
                $i = 0;
                $r = "";
                while($i ++ < $length) {
                    $r .= chr(mt_rand(0, 255));
                }
                break;
        }
        return substr(bin2hex($r), 0, $length);
    }
}



?>