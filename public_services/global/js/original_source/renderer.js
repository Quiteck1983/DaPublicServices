function getColumnRenderer(){
    let temp = globalPageLoaderJson.tableconfig;

    let renderer = [];

    for(var i = 0; i<temp.length; i++){
        if(temp[i]["renderer"].replace(/ /g,"") != ""){
            renderer[temp[i]["columnname"]] = temp[i]["renderer"];
        }
    }

    return renderer;
}
function getAllRenderers(){
    let definedRenderer=[];
    for ( var i in window) {
        if((typeof window[i]).toString()=="function"){
            if(window[i].name !== undefined){
                if(window[i].name.substring(0,9)=="renderer_"){
                    definedRenderer.push(window[i].name);
                }
            }
        }
    }
    return definedRenderer;
}


function doRenderTableData(){
    definedRenderer = getAllRenderers();
    for(var i=0; i<definedRenderer.length;i++){
        let elements = document.getElementsByClassName(definedRenderer[i]);

        if(elements.length > 0){
            for(var j=0; j < elements.length; j++){
                eval(definedRenderer[i]+"(elements[j]);");
            }       
        }
    }
}


/**
 * here only global renderers!
 * specific renderers in sub modules
*/

function renderer_switch(cell){
    let cellValue = cell.innerText;
                        
    let content = "";

    if(checkAllowed("group_management","set_rights")){
        let _class = "ThisRowIsNotSelected";
        let btn_yes = " btn-default";
        let btn_no = " btn-danger active";
        if(cellValue == 1){
          _class = "ThisRowIsSelected";
          btn_no = " btn-default";
          btn_yes = " btn-success active";
        }
        content += '<div class="btn-group btn-toggle '+_class+'" onclick = "toggleButton(this)">';


        content += '<button class="btn'+btn_no+'">'+getWord("global","no")+'</button>';
        content += '<button class="btn'+btn_yes+'">'+getWord("global","yes")+'</button>';
        content += '</div>';
    }


    


    cell.innerHTML = content;
}

function renderer_participentPassed(cell){
    let cellValue = cell.innerText;
                        
    let temp = cellValue.split("|");

    let trainingsid = temp[0];
    let userid = temp[1];
    let user_passed = temp[2];


    if(user_passed >= 0){
        if(user_passed == 0){
            cell.style.background = "red";
            cell.style.color = "white";
            cell.innerText = getWord("global","no");
        }
        else{
            cell.style.background = "green";
            cell.style.color = "white";
            cell.innerText = getWord("global","yes");
        }
    }
    else{
        let content = "";
        if(checkAllowed("training_participants","set_passed")){

            content += DaBurnerGermany.Button({
                id:""
                ,text:getWord("global","no")
                ,onclick:'training_participant_set_passed('+trainingsid+',' + userid + ',0)'
                ,cls:[
                    "btn-danger"
                    ,"btn-sm"
                    ,"btn-marginright"
                ]
                ,width:0
                ,disabled:false
            });

            content += DaBurnerGermany.Button({
                id:""
                ,text:getWord("global","yes")
                ,onclick:'training_participant_set_passed('+trainingsid+',' + userid + ',1)'
                ,cls:[
                    "btn-success"
                    ,"btn-sm"
                    ,"btn-marginright"
                ]
                ,width:0
                ,disabled:false
            });
        }
        cell.innerHTML = content;
    }                   
}

function renderer_officertrainings_setpassed(cell){
    let cellValue = cell.innerText;
    let content = "";
    
    if(checkAllowed("training_participants","set_passed")){

        
        content += DaBurnerGermany.Button({
            id:""
            ,text:getWord("global","no")
            ,onclick:'officertraining_participant_set_passed('+cellValue+',' + lastRequested["id"] + ',0)'
            ,cls:[
                "btn-danger"
                ,"btn-sm"
                ,"btn-marginright"
            ]
            ,width:0
            ,disabled:false
        });

        content += DaBurnerGermany.Button({
            id:""
            ,text:getWord("global","yes")
            ,onclick:'officertraining_participant_set_passed('+cellValue+',' + lastRequested["id"] + ',1)'
            ,cls:[
                "btn-success"
                ,"btn-sm"
                ,"btn-marginright"
            ]
            ,width:0
            ,disabled:false
        });
    }
    cell.innerHTML = content;


}

function renderer_officertrainings_truefalse(cell){
    let cellValue = cell.innerText;
                        


    if(cellValue >= 0){
        if(cellValue == 0){
            cell.style.background = "red";
            cell.style.color = "white";
            cell.innerText = getWord("global","no");
        }
        else{
            cell.style.background = "green";
            cell.style.color = "white";
            cell.innerText = getWord("global","yes");
        }
    }
    else{
        cell.innerText = "";
    }
}



function renderer_color(cell){
    let cellValue = cell.innerText;
    let temp = cellValue.split("|");

    let displayvalue = temp[0];
    let bgColor = temp[1];
    let fgColor = temp[2];

    if(bgColor != ""){
        cell.style.background = bgColor;
    }
    if(fgColor != ""){
        cell.style.color = fgColor;
    }
    cell.innerText = displayvalue;
}


function renderer_date(cell, includeErrorDateSmaller){
    let cellValue = cell.innerText;
    if(includeErrorDateSmaller){
        let isValid = new Date().getTime() <= new Date(cellValue).getTime();                    
        if(!isValid){
            cell.style.background = "red";
            cell.style.color = "white";
        }
        else{
            cell.style.background = "green";
            cell.style.color = "white";
        }
    }
    cell.innerText = DateConvertDateBaseToFormsFormat(cellValue);
}


function renderer_doParticipate(cell){
    let cellValue = cell.innerText;
    let temp = cellValue.split("|");

    let trainingsid = temp[0];
    let allow_officer_self_entry = temp[1];
    let already_entered = temp[2];
    let isDisabled = false;

    if(already_entered == 1){
        isDisabled = true;
    }

    if(allow_officer_self_entry == 1){

        
        cell.innerHTML = DaBurnerGermany.Button({
            id:""
            ,text:getWord("trainings","participate")
            ,onclick:'training_participate_self('+trainingsid+')'
            ,cls:[
                "btn-primary"
                ,"btn-sm"
            ]
            ,width:0
            ,disabled:isDisabled
        });
    }
    else{
        cell.innerText = "";
    }
}


function renderer_archiveaction(cell){

    let cellvalue = cell.innerText;

    cell.innerHTML= DaBurnerGermany.Button({
        id:""
        ,text:getWord("global","view")
        ,onclick:"doLoadPageContent('archive_details','','"+cellvalue+"')"
        ,cls:[
            "btn-primary"
        ]
        ,width:0
        ,disabled:false
    });
}

function renderer_activedetails_actions(cell){
    let cellValue = cell.innerText;
    let temp = cellValue.split("|");

    if(checkAllowed("archiv","recover_entries")){
        cell.innerHTML = DaBurnerGermany.CompositeField({
            items:[
                DaBurnerGermany.Button({
                    id:""
                    ,text:getWord("global","recover")
                    ,onclick:"archive_recover('"+temp[0]+"','"+temp[1]+"','"+temp[2]+"',"+temp[3]+")"
                    ,cls:[
                        "btn-warning"
                        ,"btn-sm"
                        ,"btn-marginright"
                    ]
                    ,width:0
                    ,disabled:false
                }),
                DaBurnerGermany.Button({
                    id:""
                    ,text:getWord("global","delete")
                    ,onclick:"archive_remove('"+temp[0]+"','"+temp[1]+"',"+temp[3]+")"
                    ,cls:[
                        "btn-danger"
                        ,"btn-sm"
                    ]
                    ,width:0
                    ,disabled:false
                })
            ]
        });
    }
    else{
        cell.innerHTML = "";
    }
}


function renderer_personalfile_entries(cell){

    let cellValue = cell.innerHTML;
    cell.classList.add("breakall");



    if(cellValue != ""){
        
        let data = JSON.parse(cellValue);

        cell.style.background = data.bgcolor;
        cell.style.color = data.fgcolor;

        let content = "";
        content+='<div>';
    
        if(data.automatic_created == 1){
            content+='<span class="badge badge-pill badge-warning tagged">'+getWord("global","automatic_created")+'</span>';        
        }
        if(data.completed == 1){
            content+='<span class="badge badge-pill badge-success tagged">'+getWord("global","completed")+'</span>';        
        }
        
        content+='<span class="badge badge-pill tagged" style = "background:'+data.bgcolor+'; color:'+data.fgcolor+'">'+data.entry_type+'</span>';        
        
        content+='</div>';
        content+='<p></p>';
        content += "<h5>";
        content+=data.createdby + "<br>" + data.createddate
        content += "</h5>";
        
        content+='<p></p>';
        content+='<p></p>';
        
        content+=data.personal_file_content;
        
        content+='<p></p>';
        content+='<p></p>';


        if(data.completed == 0){
            if(checkAllowed("personal_file","close")){
                content+= DaBurnerGermany.Button({
                    id:""
                    ,text:getWord("global","complete")
                    ,onclick:"personal_file_complete("+data.uid+")"
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
        
        if(checkAllowed("personal_file","delete")){
            content+= DaBurnerGermany.Button({
                id:""
                ,text:getWord("global","delete")
                ,onclick:"personal_file_delete("+data.uid+")"
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


function renderer_officerActions(cell){
    let cellValue = cell.innerText;
                        
    let temp = cellValue.split("|");

    let user_id = temp[0];
    let bgColor = temp[1];
    let fgColor = temp[2];

    if(bgColor != ""){
        cell.style.background = bgColor;
    }
    if(fgColor != ""){
        cell.style.color = fgColor;
    }

    let content = "";

    if(checkAllowed("control_centre", "set_officer_to_patrol")){

        content += DaBurnerGermany.Button({
            id:""
            ,text:getWord("control_centre","set_patrol")
            ,onclick:'doLoadPageContent(\'form_set_officer_patrol\',\'edit\','+user_id+')'
            ,cls:[
                "btn-warning"
                ,"btn-sm"
            ]
            ,width:0
            ,disabled:false
        });
    }
    if(checkAllowed("control_centre", "set_officer_status")){
        content += DaBurnerGermany.Button({
            id:""
            ,text:getWord("control_centre","set_status")
            ,onclick:'doLoadPageContent(\'form_set_officer_status\',\'edit\','+user_id+')'
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


function renderer_actonButtons(cell){

    let cellValue = cell.innerText;
                        
    if(cellValue > -1){

        let counter = 0;
        let editPage = "";
        let viewPage = "";


        let setRightPage = "";

        if(globalPageLoaderJson.function_buttons.editButton !== undefined){
            editPage = globalPageLoaderJson.function_buttons.editButton.goto_functionname;
            editPage = replaceEmptyChar(editPage);
            if(editPage != ""){
                counter++;
            }
        }
        if(globalPageLoaderJson.function_buttons.viewButton !== undefined){
            viewPage = globalPageLoaderJson.function_buttons.viewButton.goto_functionname;
            viewPage = replaceEmptyChar(viewPage);
            if(viewPage != ""){
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

        let allowDeleteData = globalPageLoaderJson.functionconfig.doDeleteData;
        let allowedDelete = (globalPageLoaderJson.function_buttons.deleteButton !== undefined);;
        let content = "";

        if(allowedDelete){
            counter++;
        }

        let classextra="";

        if(counter > 1){
            classextra = ' btn-marginright';
        }

        if(viewPage != ""){
            content += DaBurnerGermany.Button({
                id:""
                ,text:getWord("global","view")
                ,onclick:'doLoadPageContent(\''+viewPage+'\',\'view\','+cellValue+')'
                ,cls:[
                    "btn-primary"
                    ,"btn-sm"
                    ,classextra
                ]
                ,width:0
                ,disabled:false
            });
        }
        if(editPage != ""){
            
            content += DaBurnerGermany.Button({
                id:""
                ,text:getWord("global","edit")
                ,onclick:'doLoadPageContent(\''+editPage+'\',\'edit\','+cellValue+')'
                ,cls:[
                    "btn-warning"
                    ,"btn-sm"
                    ,classextra
                ]
                ,width:0
                ,disabled:false
            });
        }     
        if(allowDeleteData == 1 && allowedDelete){
            
            content += DaBurnerGermany.Button({
                id:""
                ,text:getWord("global","delete")
                ,onclick:'showDeleteConfirm('+cellValue+',\'\')'
                ,cls:[
                    "btn-danger"
                    ,"btn-sm"
                    ,classextra
                ]
                ,width:0
                ,disabled:false
            });
            
        }      
        if(setRightPage != ""){
            content += DaBurnerGermany.Button({
                id:""
                ,text:getWord("group_management","set_rights")
                ,onclick:'doLoadPageContent(\''+setRightPage+'\',\'edit\','+cellValue+')'
                ,cls:[
                    "btn-info"
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

function renderer_deleteParticipate(cell){
    let cellValue = cell.innerText;
    let temp = cellValue.split("|");

    let trainingsid = temp[0];
    let userid = temp[1];
    let user_passed = temp[2];


    if(user_passed >= 0){
        cell.innerHTML = "";
    }
    else{
        let content = "";

        
        if(checkAllowed("training_participants","delete")){

            content += DaBurnerGermany.Button({
                id:""
                ,text:getWord("global","delete")
                ,onclick:'training_participant_delete('+ trainingsid +', '+ userid +')'
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

