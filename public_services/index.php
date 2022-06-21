<?php

    require_once("./global/files_cfg.php");
    require_once("./global/startup_check.php");

    $databaseFileMissing = checkIfDatabaseIsConfigured(false);

    if($databaseFileMissing){
        echo "some databasefile missing<br>";
    }
    else{
        echo "all databasefiles available<br>";
    }

    $configFileMissing = checkIfSoftwareIsConfigured(false);

    if($configFileMissing){
        echo "some config missing<br>";
    }
    else{
        echo "all config available<br>";
    }


    $CopDBMissing = !checkIfDatabaseCreated("police");
    if($CopDBMissing){
        echo "cop database not ready<br>";
    }
    else{
        echo "cop database ready<br>";
    }


    $MedicDBMissing = !checkIfDatabaseCreated("medic");
    if($MedicDBMissing){
        echo "medic database not ready<br>";
    }
    else{
        echo "medic database ready<br>";
    }

    if($databaseFileMissing || $configFileMissing || $CopDBMissing==1 || $MedicDBMissing == 1){	
        header("Location:./install.php");
    }
    else{
        header("Location:./start.php");
    }

    /*
    
    todo:
    Streifengebiete - definieren + Leiststelle Streifengebiet hinzufügen zur Streife
    archiv?

    */
?>