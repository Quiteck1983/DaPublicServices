<?php

    $licensedTo = "xPandoraSnipezTv";

    
    $Author = "DaBurnerGermany";
    $copyRightBy = "(c) CopyRight by DaBurnerGermany";
 

    $fileContent = "Author:\t".$Author."\n";
    $fileContent .= "CopyRight:\t".$copyRightBy."\n";
    $fileContent .= "LicensedTo:\t".$licensedTo."\n";
    $fileContent .= "LICENSE\t".Encrypt($licensedTo);


    $fh = fopen(__DIR__.DIRECTORY_SEPARATOR."LICENSE.txt", "wb");
    fwrite($fh, $fileContent);
    fclose($fh);


    function Encrypt($licensedTo){
        $plaintext = "LicensedTo:\txPandoraSnipezTv";
        $cipher = "aes-128-gcm";
        $key = "de8fa4ea4d5b37cbb7c9d4b72a4d6b63";

        if (in_array($cipher, openssl_get_cipher_methods())){
            $ivlen = openssl_cipher_iv_length($cipher);
            $iv = openssl_random_pseudo_bytes($ivlen);
            $ciphertext = openssl_encrypt($plaintext, $cipher, $key, $options=0, $iv, $tag);
            return $ciphertext;
        }
        else{
            die("cannot create licenseFile");
        }
    }
?>