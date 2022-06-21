<?php


    $config_password=[
        "min_length" => 6
        ,"max_length" => 16
        ,"require_digit" => true
        ,"require_special_char" => true
        ,"require_capital_letter" => true
    ];

    function getPasswordRegex(){
        global $config_password;

        $specialChars = addslashes("@€!\"§$%&\/()=?\{\[\]\}\\\*\'_:;,.\-#+~<>|");

        $regex = "";
        if($config_password["require_digit"]){
            $regex.= "(?=.*[0-9])";
        }
        if($config_password["require_special_char"]){
            $regex.= "(?=.*[".$specialChars."])";
        }
        if($config_password["require_capital_letter"]){
            $regex.= "(?=.*[A-Z])";
        }
        $regex = "^".$regex."[a-zA-Z0-9".$specialChars."]{".$config_password["min_length"].",".$config_password["max_length"]."}$";

        return $regex;
    }


?>