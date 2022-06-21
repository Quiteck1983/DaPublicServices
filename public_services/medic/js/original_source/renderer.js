function renderer_PatrolActions(cell){
    let cellValue = cell.innerText;
                        
    let temp = cellValue.split("|");

    let uid = temp[0];
    let bgColor = temp[1];
    let fgColor = temp[2];

    if(bgColor != ""){
        cell.style.background = bgColor;
    }
    if(fgColor != ""){
        cell.style.color = fgColor;
    }

    let content = "";

    if(checkAllowed("control_centre", "reset_patrols")){
        content += DaBurnerGermany.Button({
            id:""
            ,text:getWord("control_centre","patrol_reset")
            ,onclick:'patrol_reset('+uid+')'
            ,cls:[
                "btn-primary"
                ,"btn-sm"
                ,"btn-marginright"
            ]
            ,width:0
            ,disabled:false
        });
    }

    if(checkAllowed("control_centre", "set_patrol_status")){
        content += DaBurnerGermany.Button({
            id:""
            ,text:getWord("control_centre","set_status")
            ,onclick:'doLoadPageContent(\'form_set_patrol_status\',\'edit\','+uid+')'
            ,cls:[
                "btn-warning"
                ,"btn-sm"
                ,"btn-marginright"
            ]
            ,width:0
            ,disabled:false
        });
    }
    cell.innerHTML = content;
}

function renderer_setPatrolStatus(cell){
    let cellValue = cell.innerText;
    let temp = cellValue.split("|");

    let uid = temp[0];
    let user_status = temp[1];
    let patrol_status = temp[2];

    let visible = true;

    if(uid == patrol_status){
        visible = false;
    }
    else if(uid == user_status){
        visible = false;
    }
    
    let content = "";
    if(visible){

        content += DaBurnerGermany.Button({
            id:""
            ,text:getWord("radio","set_status")
            ,onclick:'patrol_set_status_by_user('+ uid +')'
            ,cls:[
                "btn-warning"
                ,"btn-sm"
            ]
            ,width:0
            ,disabled:false
        });
    }
    
    cell.innerHTML = content;
}

function renderer_officerStatus(cell){
    let cellValue = cell.innerText;
    if(cellValue == 1){
        cell.style.background = "red";
        cell.style.color = "white";
        cell.innerText = getWord("global","status_deleted");
    }
    else if(cellValue == 2){
        cell.style.background = "orange";
        cell.style.color = "white";
        cell.innerText = getWord("global","status_suspended");
    }
    else{
        cell.innerText = "";
    }
}


