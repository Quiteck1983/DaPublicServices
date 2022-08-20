function customDatasaver(function_name, values, doReloadPage, doReadloadData, doChangePage, idToLoad, type2Request){

    $.ajax({
        type: "POST",
        data:{
            "function" : function_name
            ,"values" : values
        },
        url: "./php/datasetsaver_custom.php",
        success: function(response){
            let json = JSON.parse(response);

            if(json.success){
                if(doReloadPage || doReadloadData){
                    doLoadPageContent(lastRequested["functionname"], lastRequested["type"], lastRequested["id"])
                }
                else if(doChangePage){
                    doLoadPageContent(doChangePage,type2Request,idToLoad)
                }
            }
            else{
                setAlertField("id_alert",json.msg, true, "warning");
            }                
        },
        failure:function(){
            setAlertField("id_alert","Server Error", true, "warning");
        }
    });
}



function officertraining_participant_set_passed(trainingid, userid, passed){
    let data = {
        "id":trainingid
        ,"postuserid":userid
        ,"passed":passed
    };
    customDatasaver("training_participant_set_passed", JSON.stringify(data), true, false, "",-1,"");    
}

function training_participant_set_passed(trainingid, userid, passed){
    let data = {
        "id":trainingid
        ,"postuserid":userid
        ,"passed":passed
    };
    customDatasaver("training_participant_set_passed", JSON.stringify(data), false, true, "",-1,"");    
}
function training_participant_add(trainingid){
    let data = {
        "id":trainingid
        ,"postuserid":$("#id_employee_id")[0].value
    };
    customDatasaver("training_participant_add", JSON.stringify(data), false, false, "training_participants", trainingid,"view");    
}



function training_participant_delete(trainingid, userid){
    let data = {
        "id":trainingid
        ,"postuserid":userid
    };
    customDatasaver("training_participant_delete", JSON.stringify(data), false, true, "",-1,"");    
}


function training_participate_self(trainingid){
    let data = {
        "id":trainingid
    };
    customDatasaver("training_participate_self", JSON.stringify(data), false, true, "",-1,"");    
}
function patrol_set_status_by_user(status_id){
    let data = {
        "id":status_id
    };
    customDatasaver("patrol_set_status_by_user", JSON.stringify(data), false, true, "",-1,"");    
}
function patrol_reset(patrol_id){
    let data = {
        "id":patrol_id
    };
    customDatasaver("patrol_reset", JSON.stringify(data), true, false, "",-1,"");    
}
function user_set_suspended(button_name, handleforid){
    let data = {
        "id":handleforid
    };
    customDatasaver(button_name, JSON.stringify(data), false, true, "",-1,"");    
}
function user_set_deleted(button_name, handleforid){
    let data = {
        "id":handleforid
    };
    customDatasaver(button_name, JSON.stringify(data), false, true, "",-1,"");    
}
function investigation_set_closed(button_name, handleforid){
    let data = {
        "id":handleforid
    };
    customDatasaver(button_name, JSON.stringify(data), true, false, "",-1,"");    
}

function investigation_add_entry(handleforid){
    let data = getObjectValues(false);
    data["id"] = handleforid;
    customDatasaver("investigation_add_entry", JSON.stringify(data), false, false, "form_investigation",handleforid,"view");    
}

function control_centre_set_by_user(){
    let data = {};
    customDatasaver("control_centre_set_by_user", JSON.stringify(data), true, false, "",-1,"");    
}

function control_centre_reset(){
    let data = {};
    customDatasaver("control_centre_reset", JSON.stringify(data), true, false, "",-1,"");    
}

function patrol_service_end_by_user(functionname){
    let data = {};
    customDatasaver(functionname, JSON.stringify(data), true, false, "",-1,"");    
}

function patrol_leave_by_user(functionname){
    let data = {};
    customDatasaver(functionname, JSON.stringify(data), false, true, "",-1,"");    
}
function password_reset(previousPage, userid){
    let data = {
        "id" : userid
        ,"password" : $("#id_new_password")[0].value
    };
    let viewtype = 'view';
    if(userid == -1){
        viewtype = "";
    }
    customDatasaver("password_reset", JSON.stringify(data), false, false, previousPage, userid,viewtype);    
}

function group_rights_save(){
    let data = {
        "groupRightIds" : getSelectedRights()
        ,"id" : lastRequested["id"]
    };
    
    customDatasaver("group_rights_save", JSON.stringify(data), false, false, "group_management", -1,"");    
}

function files_remove_license(licenseID){
    let data = {
        "id" : lastRequested["id"]
        ,"licenseid" : licenseID
    };
    customDatasaver("files_remove_license", JSON.stringify(data), true, false, "", -1,"");    
}

function files_grant_license(){
    let data = {
        "id" : lastRequested["id"]
        ,"licenseid" : $("#id_available_licenses")[0].value
    };
    customDatasaver("files_grant_license", JSON.stringify(data), true, false, "", -1,"");    
}

function files_add_entry(files_uid){
    let data = getObjectValues(false);
    data.file_uid = files_uid;

    customDatasaver("files_add_entry", JSON.stringify(data), false, false, "form_files", files_uid,"view");    
}
function save_personal_file_entry(){
    let data = getObjectValues(false);
    data.userid = lastRequested["id"];

    customDatasaver("save_personal_file_entry", JSON.stringify(data), false, false, "custom_personal_file", lastRequested["id"],"");    
}
function personal_file_complete(id){
    let data = {
        "id" : id
    };
    customDatasaver("personal_file_complete", JSON.stringify(data), true, false, "", -1,"");    
}
function personal_file_delete(id){
    let data = {
        "id" : id
    };
    customDatasaver("personal_file_delete", JSON.stringify(data), true, false, "", -1,"");    
}
function files_entry_delete(entryid){
    let data = {
        "id" : entryid
    };
    customDatasaver("files_entry_delete", JSON.stringify(data), true, false, "",-1,"");    
}
function files_entry_complete(entryid){
    let data = {
        "id" : entryid
    };
    customDatasaver("files_entry_complete", JSON.stringify(data), true, false, "",-1,"");    
}
function files_manhunt_end(entryid){
    let data = {
        "id" : entryid
    };
    customDatasaver("files_manhunt_end", JSON.stringify(data), true, false, "",-1,"");    
}
function registered_vehicle_reset_wanting(entryid){
    let data = {
        "id" : entryid
    };
    customDatasaver("registered_vehicle_reset_wanting", JSON.stringify(data), false, true, "",-1,"");    
}

function registered_vehicle_end_manhunt(vehicle_id){
    let data = {
        "id" : vehicle_id
    };
    customDatasaver("registered_vehicle_end_manhunt", JSON.stringify(data), true, false, "",-1,"");    
}


function archive_recover(tablename, primaryColName, deletedCol, uid){
    let data = {
        "id" : uid
        ,"tablename" : tablename
        ,"deletedcol" : deletedCol
        ,"primarycol" : primaryColName
    };
    customDatasaver("archive_recover", JSON.stringify(data), true, false, "",-1,"");    
}
function archive_remove(tablename, primaryColName, uid){
    let data = {
        "id" : uid
        ,"tablename" : tablename
        ,"primarycol" : primaryColName
    };
    customDatasaver("archive_remove", JSON.stringify(data), true, false, "",-1,"");    
}

function files_handle_meta(buttonid){

    let columnname = '';
    if(buttonid == "files_delete"){
        columnname = 'file_deleted'
    }
    else if(buttonid == "files_set_blackend"){
        columnname = 'file_blackend'
    }
    else if(buttonid == "files_set_closed"){
        columnname = 'file_closed'
    }

    let data = {
        "id" : lastRequested["id"]
        ,"columnname" : columnname
    };
    customDatasaver("files_handle_meta", JSON.stringify(data), true, false, "", -1,"");    
}