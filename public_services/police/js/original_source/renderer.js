

function renderer_isWanted(cell){
    let cellValue = cell.innerText;
                        
    if(cellValue == 1){
        cell.style.background = "red";
        cell.style.color = "white";
        cell.innerText = getWord("manhunt","status_is_wanted");
    }
    else{
        cell.style.background = "green";
        cell.style.color = "white";
        cell.innerText = getWord("manhunt","status_not_wanted");
    }
}

function renderer_importantEntry(cell){
    let cellValue = cell.innerText;
                        
    if(cellValue == 1){
        cell.style.background = "red";
        cell.style.color = "white";
        cell.innerText = getWord("global","yes");
    }
    else{
        cell.innerText = getWord("global","no");
    }
}



function renderer_lawbooklaws_actions(cell){

    let cellValue = cell.innerText;
                        
    if(cellValue > -1){

        let counter = 0;
        let editPage = "";
        let setRightPage = "";

        if(globalPageLoaderJson.function_buttons.editButton !== undefined){
            editPage = globalPageLoaderJson.function_buttons.editButton.goto_functionname;
            editPage = replaceEmptyChar(editPage);
            if(editPage != ""){
                counter++;
            }
        }
        
        if(globalPageLoaderJson.function_buttons.setRightsButton !== undefined){
            setRightPage = globalPageLoaderJson.function_buttons.setRightsButton.goto_functionname;
            setRightPage = replaceEmptyChar(setRightPage);
            if(setRightPage != ""){
                counter++;
            }
        }


        allowedDelete = checkAllowed(lastRequested["functionname"], "delete");


        let content = "";

        if(allowedDelete){
            counter++;
        }

        let classextra="";

        if(counter > 1){
            classextra = ' btn-marginright';
        }

        content += DaBurnerGermany.Button({
            id:""
            ,text:getWord("global","edit")
            ,onclick:'doLoadPageContent(\'form_crimes\',\'edit\','+cellValue+')'
            ,cls:[
                "btn-warning"
                ,"btn-sm"
                ,classextra
            ]
            ,width:0
            ,disabled:false
        });

        if(allowedDelete){
            content += DaBurnerGermany.Button({
                id:""
                ,text:getWord("global","delete")
                ,onclick:'showDeleteConfirm('+cellValue+',\'delete_lawbook_laws\')'
                ,cls:[
                    "btn-danger"
                    ,"btn-sm"
                    ,classextra
                ]
                ,width:0
                ,disabled:false
            });
        }      
        
        cell.innerHTML = content;
    }
}

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

    if(checkAllowed("control_centre", "set_patrol_area")){
        content += DaBurnerGermany.Button({
            id:""
            ,text:getWord("control_centre","set_area")
            ,onclick:'doLoadPageContent(\'form_set_patrol_area\',\'add\','+uid+')'
            ,cls:[
                "btn-info"
                ,"btn-sm"
                ,"btn-marginright"
            ]
            ,width:0
            ,disabled:false
        });
    }
    cell.innerHTML = content;
}

function renderer_removeLicenses(cell){
    let cellValue = cell.innerText;
    let content = "";

    
    if(checkAllowed("file_licenses","remove")){
        content += DaBurnerGermany.Button({
            id:""
            ,text:getWord("files","remove_license")
            ,onclick:'files_remove_license('+cellValue+')'
            ,cls:[
                "btn-danger"
                ,"btn-sm"
            ]
            ,width:0
            ,disabled:false
        });
    }

    cell.innerHTML = content;
}


function renderer_numberFieldLawBookGrid(cell){
    let cellValue = cell.innerText;
    

    
    cell.innerHTML = DaBurnerGermany.NumberField({
        id:"id_lawbook_id_" + cellValue
        ,fieldLabel:""
        ,cls:[]
        ,hidden:false
        ,width:0
        ,height:0
        ,onKeyup:"checkIfFormIsValid(true)"
        ,allowBlank:false
        ,readOnly:false
        ,disabled:false
        ,value:0
        ,allowDecimals:false
        
    });     
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


function renderer_paragraph(cell){
    
    
    cell.innerText = '§'+cell.innerText;
}

function renderer_motValid(cell){
    renderer_date(cell,true);
}

function renderer_file_complaints_overview_1(cell){
    render_complainstype(cell, 1);
}
function renderer_file_complaints_overview_2(cell){
    render_complainstype(cell, 2);
}
function renderer_file_complaints_overview_3(cell){
    render_complainstype(cell, 3);
}

function render_complainstype(cell, statusid){

    let cellValue = cell.innerText;
    let isDisabled = false;
    if(cellValue == 0){
        isDisabled = true;
    }
    
    cell.innerHTML = DaBurnerGermany.Button({
        id:""
        ,text:cellValue
        ,onclick:"doLoadPageContent('view_criminal_complaints_byfile_"+statusid+"', ''," + lastRequested["id"] + ")"
        ,cls:[
            "btn-primary"
            ,"btn-block"
            ,"btn-sm"
        ]
        ,width:0
        ,disabled:isDisabled
    });
}
function renderer_file_complaints_overview_reporter(cell){

    let cellValue = cell.innerText;
    let isDisabled = false;
    if(cellValue == 0){
        isDisabled = true;
    }
    
    cell.innerHTML = DaBurnerGermany.Button({
        id:""
        ,text:cellValue
        ,onclick:"doLoadPageContent('view_criminal_complaints_byfile_0','', " + lastRequested["id"] + ")"
        ,cls:[
            "btn-primary"
            ,"btn-block"
            ,"btn-sm"
        ]
        ,width:0
        ,disabled:isDisabled
    });
}

function renderer_manhunt_actions(cell){
    let cellValue = cell.innerText;

    if(cellValue != ""){
        let temp = cellValue.split("|");

        let func = temp[0];
        let param1 = temp[1];
        let param2 = temp[2];

        let buttontext = getWord("global","open_file");
        let onclickfunction = func+"('"+param1+"','view',"+param2+")";

        let allowed = checkAllowed("files","view");


        if(func == "registered_vehicle_reset_wanting"){
            buttontext=getWord("manhunt","end_is_wanted");
            onclickfunction = func+"("+param1+")";

            allowed = checkAllowed("manhunt","end");

        }

        if(allowed){
            cell.innerHTML = DaBurnerGermany.Button({
                id:""
                ,text:buttontext
                ,onclick:onclickfunction
                ,cls:[
                    "btn-primary"
                    ,"btn-block"
                ]
                ,width:0
                ,disabled:false
            });
        }
        else{
            cell.innerHTML='';
        }

        
    }
}

function renderer_manhunt_wantingtype(cell){
    let cellValue = cell.innerText;
    cell.innerText = getWord("manhunt",cellValue);   
}

function renderer_file_entries(cell){

    let cellValue = cell.innerHTML;
    cell.classList.add("breakall");



    if(cellValue != ""){
        let data = JSON.parse(cellValue);
        
        cell.style.background = data.bgcolor;
        cell.style.color = data.fgcolor;

        let content = "";
        content = "<h5>";
        if(data.crimes == ""){
            content+=getWord("crime","no_crime_deposited");
        }
        else{
            content+=globalReplace(data.crimes);
        }
        content += "</h5>";
        content+='<div>';
    
        if(data.file_is_wanted == 1){
            if(data.file_is_wanted_finished == 1){
                content+='<span class="badge badge-pill badge-warning tagged">'+getWord("manhunt","old_manhunt")+'</span>';        
    
            }
            else{
                content+='<span class="badge badge-pill badge-danger tagged">'+getWord("manhunt","active_manhunt")+'</span>';        
            }
        }
    
        
    
        content+='<span class="badge badge-pill tagged" style = "background:'+data.bgcolor+'; color:'+data.fgcolor+'">'+data.typeofentry+'</span>';        
    
    
        if(data.closed == 1){
            content+='<span class="badge badge-pill badge-success tagged">'+getWord("global","completed")+'</span>';    
        }
        content+="</div>";
        content+='<p></p>'
    
        content+="<strong>"+getWord("global",'createdby') + ": </strong>" + data.entry_by_officer;
        content+="<br>"
        content+="<strong>"+getWord("global",'createddate') + ": </strong>" + data.entry_createddate;
        content+="<br>"
        content+="<strong>"+getWord("global",'information') + "</strong><br>" + data.entry_content;
        content+='<p></p>'
        content+="<strong>"+getWord("crimes",'penalties_imposed') + ":</strong><br>";
    
        content+= data.detention_time + " "+ getWord("crimes","detention_time") + "<br>";
        content+= data.fine + " " + getWord("crimes","fine") + "<br>";
    
        content+='<p></p>'
        content+="<strong>"+getWord("files",'file_entry_number') + ": </strong>" + data.file_entry_number;     
        
        content+='<p></p>'

        if(data.closed == 0){
            if(checkAllowed("file_entries","close")){
                content+= DaBurnerGermany.Button({
                    id:""
                    ,text:getWord("global","complete")
                    ,onclick:"files_entry_complete("+data.uid+")"
                    ,cls:[
                        "btn-success"
                        ,"btn-sm"
                        ,"btn-marginright"
                    ]
                    ,width:0
                    ,disabled:false
                });
            }
        }
        
        
        if(checkAllowed("file_entries","close")){
            content+= DaBurnerGermany.Button({
                id:""
                ,text:getWord("global","delete")
                ,onclick:"files_entry_delete("+data.uid+")"
                ,cls:[
                    "btn-danger"
                    ,"btn-sm"
                    
                ]
                ,width:0
                ,disabled:false
            });
        }

        cell.innerHTML=content;
    }
    else{
        cell.classList.add("bg-dark");
    }           

}