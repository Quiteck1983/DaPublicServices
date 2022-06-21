
function getField(data){
    let config=[];

    config.push('<div class="form-group">');
    config.push('<label for="'+data.id+'">'+data.label+'</label>');
    config.push('<input type="'+data.type+'" class="form-control" id="'+data.id+'" '+(data.helperid != "" ?  'aria-describedby="'+data.helperid+'"':"")+' placeholder="'+data.placeholder+'" '+(data.onkeyup != "" ? 'onkeyup="'+data.onkeyup+'"' : '')+'>');
    if(data.helperid != ""){
        config.push('<small id="'+data.helperid+'" class="form-text text-muted">'+data.helpertext+'</small>');
    }
    config.push('</div>');

    return config.join("");

}

function getPageContent(database_cfg_done, software_cfg_done, databases_done){
    
    let config = [];
    if(!database_cfg_done){
        config.push('<h4>');
        config.push('Database Configuration');
        config.push('</h4>');
        config.push('<div class="alert alert-warning" role="alert" style="display:none" id = "id_alert">');
        config.push('</div>');

        let fieldcfg = getFieldConfig("database_cfg_main");
        for(var i=0; i<fieldcfg.length; i++){
            config.push(getField(fieldcfg[i]));
        }



        config.push('<button type="button" id="test_database_connection" class="btn btn-primary btn-block" onclick="testDatabaseConnection()">test connection</button>');
    }
    else{
        config.push('<h4 style = "color:green">');
        config.push('Database Configuration done ');
        config.push('<button type="button" id="reset_database_configuration" class="btn btn-danger" onclick="reset_database_connection()">reset database config</button> ');
        config.push('</h4>');

        if(!software_cfg_done){
            config.push('<h4>');
            config.push('System Configuration');
            config.push('</h4>');
            config.push('<div class="alert alert-warning" role="alert" style="display:none" id = "id_alert">');
            config.push('</div>');
    
            let fieldcfg = getFieldConfig("global_configs");
            for(var i=0; i<fieldcfg.length; i++){
                config.push(getField(fieldcfg[i]));
            }
    
            config.push('<button type="button" id="save_system_config" class="btn btn-primary btn-block" onclick="saveSystemConfig()">save configuration</button>');
        }
        else{
            config.push('<h4 style = "color:green">');
            config.push('System Configuration done ');
            config.push('<button type="button" id="reset_system_configuration" class="btn btn-danger" onclick="doResetSystemConfig()">reset system config</button> ');
            config.push('</h4>');
            if(!databases_done){
                config.push('<h4>');
                config.push('Database create');
                config.push('</h4>');
                config.push('This can take several minutes!');
                
                config.push('<button type="button" class="btn btn-primary btn-block" onclick="startDatabaseCreation()">create entire database</button>');
            }
            else{
                config.push('<h4 style = "color:green">');
                config.push('Databases created');
                config.push('</h4>');
            }

        }

        
    }

    
    $("#id_content")[0].innerHTML=config.join("");


}

function getFieldConfig(scenario){
    let retval = [];
    if(scenario == "database_cfg_main"){
        let fieldcfg=[];
        
        fieldcfg[0] = [];
        fieldcfg[0]["id"] = "database_host";
        fieldcfg[0]["label"] = "database host";
        fieldcfg[0]["type"] = "text";
        fieldcfg[0]["helperid"] = "database_host_helper";
        fieldcfg[0]["helpertext"] = "Please enter the hostname including port. Example localhost:3306 or 127.1.1.0:3306";
        fieldcfg[0]["placeholder"] = "Enter host with port";
        fieldcfg[0]["onkeyup"] = "";
        
        fieldcfg[1] = [];
        fieldcfg[1]["id"] = "database_user";
        fieldcfg[1]["label"] = "database user";
        fieldcfg[1]["type"] = "text";
        fieldcfg[1]["helperid"] = "";
        fieldcfg[1]["helpertext"] = "";
        fieldcfg[1]["placeholder"] = "Enter username for database";
        fieldcfg[1]["onkeyup"] = "";
        
        fieldcfg[2] = [];
        fieldcfg[2]["id"] = "database_pass";
        fieldcfg[2]["label"] = "password";
        fieldcfg[2]["type"] = "password";
        fieldcfg[2]["helperid"] = "";
        fieldcfg[2]["helpertext"] = "";
        fieldcfg[2]["placeholder"] = "Enter Password";
        fieldcfg[2]["onkeyup"] = "";
        retval = fieldcfg;
    }
    else if(scenario == "database_cfg_extra"){
        let fieldcfg=[];
        
        fieldcfg[0] = [];
        fieldcfg[0]["id"] = "database_cops";
        fieldcfg[0]["label"] = "Cops Database name";
        fieldcfg[0]["type"] = "text";
        fieldcfg[0]["helperid"] = "database_cops_helper";
        fieldcfg[0]["helpertext"] = "USE NOT EXISTIG DATABASE NAME - IF EXISTING IT WILL BE DELETED!";
        fieldcfg[0]["placeholder"] = "Enter name for database";
        fieldcfg[0]["onkeyup"] = "checkIfSaveDatabaseConfigAllowed()";
        
        fieldcfg[1] = [];
        fieldcfg[1]["id"] = "database_medics";
        fieldcfg[1]["label"] = "Medics Database name";
        fieldcfg[1]["type"] = "text";
        fieldcfg[1]["helperid"] = "database_medics_help";
        fieldcfg[1]["helpertext"] = "USE NOT EXISTIG DATABASE NAME - IF EXISTING IT WILL BE DELETED!";
        fieldcfg[1]["placeholder"] = "Enter name for database";
        fieldcfg[1]["onkeyup"] = "checkIfSaveDatabaseConfigAllowed()";

        retval = fieldcfg;
    }
    else if(scenario == "global_configs"){
        let fieldcfg=[];
        
        fieldcfg[0] = [];
        fieldcfg[0]["id"] = "default_language";
        fieldcfg[0]["label"] = "default language";
        fieldcfg[0]["type"] = "text";
        fieldcfg[0]["helperid"] = "default_language";
        fieldcfg[0]["helpertext"] = "en(english) or de(german) allowed! if input is not matching it will be en!";
        fieldcfg[0]["placeholder"] = "Enter de or en";
        fieldcfg[0]["onkeyup"] = "checkIfSaveSoftwarecfg_allowed()";
        
        fieldcfg[1] = [];
        fieldcfg[1]["id"] = "server_name";
        fieldcfg[1]["label"] = "servername";
        fieldcfg[1]["type"] = "text";
        fieldcfg[1]["helperid"] = "";
        fieldcfg[1]["helpertext"] = "";
        fieldcfg[1]["placeholder"] = "Enter your servername";
        fieldcfg[1]["onkeyup"] = "checkIfSaveSoftwarecfg_allowed()";
        
        fieldcfg[2] = [];
        fieldcfg[2]["id"] = "system_user";
        fieldcfg[2]["label"] = "systemuser";
        fieldcfg[2]["type"] = "text";
        fieldcfg[2]["helperid"] = "system_user";
        fieldcfg[2]["helpertext"] = "This username is Systemuser for PD and MD";
        fieldcfg[2]["placeholder"] = "Enter the system username";
        fieldcfg[2]["onkeyup"] = "checkIfSaveSoftwarecfg_allowed()";
        
        fieldcfg[3] = [];
        fieldcfg[3]["id"] = "system_user_password";
        fieldcfg[3]["label"] = "systemuser password";
        fieldcfg[3]["type"] = "password";
        fieldcfg[3]["helperid"] = "";
        fieldcfg[3]["helpertext"] = "";
        fieldcfg[3]["placeholder"] = "Enter a password";
        fieldcfg[3]["onkeyup"] = "checkIfSaveSoftwarecfg_allowed()";

        retval = fieldcfg;
    }

    return retval;

}

function addFieldsForDatabaseNames(){
    $("#id_alert").removeClass("alert-warning");
    $("#id_alert").addClass("alert-success");

    $("#test_database_connection").hide();

    $("#database_pass").prop('readonly', true);
    $("#database_pass")[0].style.background = "green";
    
    $("#database_user").prop('readonly', true);
    $("#database_user")[0].style.background = "green";
    
    $("#database_host").prop('readonly', true);
    $("#database_host")[0].style.background = "green";

    
    let config = [];

    let fieldcfg = getFieldConfig("database_cfg_extra");
    for(var i=0; i<fieldcfg.length; i++){
        config.push(getField(fieldcfg[i]));
    }

    config.push('<button type="button" id="save_database_config" class="btn btn-primary btn-block" onclick="saveDatabaseConfig()">save database config</button>');

    $("#id_content").append(config.join(""));

}


function saveSystemConfig(){
    let alertel = document.getElementById("id_alert");
    $.ajax({
        type: "POST",
        data:{
            "function" : "save_system_config"
            ,"language" : $("#default_language")[0].value
            ,"servername" : $("#server_name")[0].value
            ,"system_user" : $("#system_user")[0].value
            ,"system_user_pass" : $("#system_user_password")[0].value
        },
        url: "./install/php/phpfunctions.php",
        success: function(response){
            let json = JSON.parse(response);
            if(json.success){
                alertel.innerHTML = json.msg;
                alertel.style.display = "";
                window.location.reload();
            }
            else{
                alertel.innerHTML = json.msg;
                alertel.style.display = "";
            }                
        },
        failure:function(){
            alertel.innerHTML = "Server Error";
            alertel.style.display = "";
        }
    });
}

function testDatabaseConnection(){
    let alertel = document.getElementById("id_alert");
    $.ajax({
        type: "POST",
        data:{
            "function" : "test_db_connection"
            ,"servername" : $("#database_host")[0].value
            ,"user" : $("#database_user")[0].value
            ,"password" : $("#database_pass")[0].value
        },
        url: "./install/php/phpfunctions.php",
        success: function(response){
            let json = JSON.parse(response);
            if(json.success){
                alertel.innerHTML = json.msg;
                alertel.style.display = "";


                addFieldsForDatabaseNames();

                setTimeout(function(){ 
                    $("#id_alert").fadeOut("slow");
                    $("#id_alert").removeClass("alert-success");
                    $("#id_alert").removeClass("alert-warning");
                }, 5*1000);
            }
            else{
                alertel.innerHTML = json.msg;
                alertel.style.display = "";
            }                
        },
        failure:function(){
            alertel.innerHTML = "Server Error";
            alertel.style.display = "";
        }
    });
}



function checkIfSaveSoftwarecfg_allowed(){

    let fieldIds = [
        "default_language"
        ,"server_name"
        ,"system_user"
        ,"system_user_password"
    ];

    var valid = false;

    for(var i=0; i<fieldIds.length; i++){

        let form = document.getElementById(fieldIds[i]);

        
        if(form.value.replace(/ /g,"").replace(/\n/g,"")!=""){
            form.style.border="";

        }
        else{
            valid=false;
            form.style.border="3px solid red";
        }
    }

    if($("#save")[0]){
        $("#save_database_config")[0].disabled = !valid;
    }
}
function checkIfSaveDatabaseConfigAllowed(){

    let fieldIds = [
        "database_pass"
        ,"database_user"
        ,"database_host"
        ,"database_cops"
        ,"database_medics"
    ];

    var valid = false;

    for(var i=0; i<fieldIds.length; i++){

        let form = document.getElementById(fieldIds[i]);

        
        if(form.value.replace(/ /g,"").replace(/\n/g,"")!=""){
            form.style.border="";

        }
        else{
            valid=false;
            form.style.border="3px solid red";
        }
        
    }

    if($("#save")[0]){
        $("#save_database_config")[0].disabled = !valid;
    }
}

function saveDatabaseConfig(){
    let alertel = document.getElementById("id_alert");
    $.ajax({
        type: "POST",
        data:{
            "function" : "save_db_config"
            ,"servername" : $("#database_host")[0].value
            ,"user" : $("#database_user")[0].value
            ,"password" : $("#database_pass")[0].value
            ,"scheme_cops" : $("#database_cops")[0].value
            ,"scheme_medics" : $("#database_medics")[0].value
        },
        url: "./install/php/phpfunctions.php",
        success: function(response){
            let json = JSON.parse(response);
            if(json.success){
                window.location.reload();
            }
            else{
                alertel.innerHTML = json.msg;
                alertel.style.display = "";
            }                
        },
        failure:function(){
            alertel.innerHTML = "Server Error";
            alertel.style.display = "";
        }
    });
}

function reset_database_connection(){
    let alertel = document.getElementById("id_alert");
    $.ajax({
        type: "POST",
        data:{
            "function" : "reset_db_config"
        },
        url: "./install/php/phpfunctions.php",
        success: function(response){
            let json = JSON.parse(response);
            if(json.success){
                window.location.reload();
            }
            else{
                alertel.innerHTML = json.msg;
                alertel.style.display = "";
            }                
        },
        failure:function(){
            alertel.innerHTML = "Server Error";
            alertel.style.display = "";
        }
    });
}
function doResetSystemConfig(){
    let alertel = document.getElementById("id_alert");
    $.ajax({
        type: "POST",
        data:{
            "function" : "reset_software_config"
        },
        url: "./install/php/phpfunctions.php",
        success: function(response){
            let json = JSON.parse(response);
            if(json.success){
                window.location.reload();
            }
            else{
                alertel.innerHTML = json.msg;
                alertel.style.display = "";
            }                
        },
        failure:function(){
            alertel.innerHTML = "Server Error";
            alertel.style.display = "";
        }
    });
}
function startDatabaseCreation(){
    let alertel = document.getElementById("id_alert");
    $.ajax({
        type: "POST",
        url: "./install/php/create_database.php",
        success: function(response){
            let json = JSON.parse(response);
            if(json.success){
                window.location.reload();
            }
            else{
                alertel.innerHTML = json.msg;
                alertel.style.display = "";
            }                
        },
        failure:function(){
            alertel.innerHTML = "Server Error";
            alertel.style.display = "";
        }
    });
}