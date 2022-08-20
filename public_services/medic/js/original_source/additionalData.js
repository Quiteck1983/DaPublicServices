function additionalData_officer_trainings(data){
    getExtraButtonsBottom(globalPageLoaderJson.extraButtons);
    
    
    DaBurnerGermany.AddToTitle(" - " + data.officername.officer_name);

    DaBurnerGermany.create();

    DaBurnerGermany.AddToBody(
        DaBurnerGermany.Grid({
            id:""
            ,columns:convertTableHeader(data.overview.header)
            ,tabledata:data.overview.values
            ,renderer:{
                "officer_passed":"renderer_officertrainings_truefalse"
                ,"officer_entered":"renderer_officertrainings_truefalse"
                ,"uid":"renderer_officertrainings_setpassed"
            }
            ,cls:["table-dark"]
            ,clsTableHead:[]
            ,clsTableBody:["tbody-white"]
            ,needsCount:false
            ,allowQuicksearch:false  
        })
    );
}

function additionalData_form_files_add_entry(data){

    let btnhtml = $("#save").parent().parent()[0].outerHTML;

    $("#save").parent().parent().remove();




    DaBurnerGermany.AddToBody(
        '<h4>'+getWord("files","injuries")+'</h4>'
    );
    DaBurnerGermany.AddToBody(
        '<div class= "form-row">'
        + '<div class= "form-group col-md-4"></div>'
        + DaBurnerGermany.TextField({
            id:"id_injury_head"
            ,type:"text"
            ,fieldLabel:getWord("injuries","head")
            ,cls:[]
            ,hidden:false
            ,width:4
            ,height:0
            ,onKeyup:"checkIfFormIsValid()"
            ,allowBlank:true
            ,readOnly:false
            ,disabled:false
            ,value:""
        })
        +'<div class= "form-group col-md-4"></div>'
        +'</div>'
    );
    DaBurnerGermany.AddToBody(
        '<div class= "form-row">'
        + '<div class= "form-group col-md-4"></div>'
        + DaBurnerGermany.TextField({
            id:"id_injury_neck"
            ,type:"text"
            ,fieldLabel:getWord("injuries","neck")
            ,cls:[]
            ,hidden:false
            ,width:4
            ,height:0
            ,onKeyup:"checkIfFormIsValid()"
            ,allowBlank:true
            ,readOnly:false
            ,disabled:false
            ,value:""
        })
        +'<div class= "form-group col-md-4"></div>'
        +'</div>'
    );
    DaBurnerGermany.AddToBody(
        '<div class= "form-row">'
        + DaBurnerGermany.TextField({
            id:"id_injury_leftarm"
            ,type:"text"
            ,fieldLabel:getWord("injuries","left_arm")
            ,cls:[]
            ,hidden:false
            ,width:4
            ,height:0
            ,onKeyup:"checkIfFormIsValid()"
            ,allowBlank:true
            ,readOnly:false
            ,disabled:false
            ,value:""
        })
        + DaBurnerGermany.TextField({
            id:"id_injury_torso"
            ,type:"text"
            ,fieldLabel:getWord("injuries","torso")
            ,cls:[]
            ,hidden:false
            ,width:4
            ,height:0
            ,onKeyup:"checkIfFormIsValid()"
            ,allowBlank:true
            ,readOnly:false
            ,disabled:false
            ,value:""
        })
        + DaBurnerGermany.TextField({
            id:"id_injury_rightarm"
            ,type:"text"
            ,fieldLabel:getWord("injuries","right_arm")
            ,cls:[]
            ,hidden:false
            ,width:4
            ,height:0
            ,onKeyup:"checkIfFormIsValid()"
            ,allowBlank:true
            ,readOnly:false
            ,disabled:false
            ,value:""
        })
        +'</div>'
    );
    DaBurnerGermany.AddToBody(
        '<div class= "form-row">'
        + '<div class= "form-group col-md-4"></div>'
        + DaBurnerGermany.TextField({
            id:"id_injury_stomach"
            ,type:"text"
            ,fieldLabel:getWord("injuries","stomach")
            ,cls:[]
            ,hidden:false
            ,width:4
            ,height:0
            ,onKeyup:"checkIfFormIsValid()"
            ,allowBlank:true
            ,readOnly:false
            ,disabled:false
            ,value:""
        })
        +'<div class= "form-group col-md-4"></div>'
        +'</div>'
    );
    
    DaBurnerGermany.AddToBody(
        '<div class= "form-row">'
        + DaBurnerGermany.TextField({
            id:"id_injury_leftleg"
            ,type:"text"
            ,fieldLabel:getWord("injuries","left_leg")
            ,cls:[]
            ,hidden:false
            ,width:4
            ,height:0
            ,onKeyup:"checkIfFormIsValid()"
            ,allowBlank:true
            ,readOnly:false
            ,disabled:false
            ,value:""
        })
        + DaBurnerGermany.TextField({
            id:"id_injury_hip"
            ,type:"text"
            ,fieldLabel:getWord("injuries","hip")
            ,cls:[]
            ,hidden:false
            ,width:4
            ,height:0
            ,onKeyup:"checkIfFormIsValid()"
            ,allowBlank:true
            ,readOnly:false
            ,disabled:false
            ,value:""
        })
        + DaBurnerGermany.TextField({
            id:"id_injury_rightleg"
            ,type:"text"
            ,fieldLabel:getWord("injuries","right_leg")
            ,cls:[]
            ,hidden:false
            ,width:4
            ,height:0
            ,onKeyup:"checkIfFormIsValid()"
            ,allowBlank:true
            ,readOnly:false
            ,disabled:false
            ,value:""
        })
        +'</div>'
    );
    
    DaBurnerGermany.AddToBody(
        '<div class= "form-row">'
        + DaBurnerGermany.TextField({
            id:"id_injury_leftfoot"
            ,type:"text"
            ,fieldLabel:getWord("injuries","left_foot")
            ,cls:[]
            ,hidden:false
            ,width:4
            ,height:0
            ,onKeyup:"checkIfFormIsValid()"
            ,allowBlank:true
            ,readOnly:false
            ,disabled:false
            ,value:""
        })
        +'<div class= "form-group col-md-4"></div>'
        + DaBurnerGermany.TextField({
            id:"id_injury_rightfoot"
            ,type:"text"
            ,fieldLabel:getWord("injuries","right_foot")
            ,cls:[]
            ,hidden:false
            ,width:4
            ,height:0
            ,onKeyup:"checkIfFormIsValid()"
            ,allowBlank:true
            ,readOnly:false
            ,disabled:false
            ,value:""
        })
        +'</div>'
    );

    DaBurnerGermany.AddToBody(btnhtml);
}
function additionalData_form_files(data){
    DaBurnerGermany.AddToTitle(" - " + data.information.file_number);

    if(data.information.is_dead == 1 || data.information.is_violent == 1 || data.information.is_gangmember == 1){
        let infocontent = "<h5>"+getWord("files","marked_as")+"</h5>";
        let temp = "";

        if(data.information.is_dead == 1){
            
            temp+=(temp == "" ? "" : "<br>") + "- " +  getWord("files","marked_dead");
        }
        if(data.information.is_violent == 1){
            temp+=(temp == "" ? "" : "<br>") + "- " +  getWord("files","marked_violent");
        }
        if(data.information.is_gangmember == 1){
            temp+=(temp == "" ? "" : "<br>") + "- " +  getWord("files","marked_gangmember");
        }

        infocontent+=temp;
        
        setAlertField("id_alertinfo", infocontent, true,"warning");
    }
    

    let fsitems=[];


    if(data.emergency_contacts !== undefined && data.emergency_contacts.values !== undefined){
        
        fsitems.push(
            DaBurnerGermany.Button({
                id:""
                ,text:getWord("files","add_emergency_contact")
                ,onclick:"doLoadPageContent('form_files_emergency_contacts','add',"+lastRequested["id"]+")"
                ,cls:[
                    "btn-success"
                    ,"btn-block"
                ]
                ,width:6
                ,disabled:false
            })
        
        );
        
    }
    

    if(data.emergency_contacts !== undefined && data.emergency_contacts.values.length > 0){
        fsitems.push(
            DaBurnerGermany.Grid({
                id:""
                ,columns:convertTableHeader(data.emergency_contacts.header)
                ,tabledata:data.emergency_contacts.values
                ,renderer:{
                    "uid":"renderer_removeEmergencyContacts"
                }
                ,cls:["table-dark"]
                ,clsTableHead:[]
                ,clsTableBody:["tbody-white"]
                ,needsCount:false
                ,allowQuicksearch:false  
            })
        );
    }
    else{
        fsitems.push("<p>"+getWord("global","no_data")+"</p>");
    }

    if(data.emergency_contacts !== undefined){
        DaBurnerGermany.AddToBody(
            DaBurnerGermany.FieldSet({
                id:""
                ,title:getWord("files","emergency_contacts") + " (" + data.emergency_contacts.values.length+")"
                ,startCollapsed:true
                ,collapsible:true
                ,colorscheme:"dark"
                ,items:fsitems 
            })
        );
    }
    


    if(data.treatments !== undefined){
        if(data.treatments.values !== undefined){
            for(var i = 0; i < data.treatments.values.length; i++){
                let entry = data.treatments.values[i];

                

                let _title = entry.file_entry_number;
                _title += " - " + entry.creator;
                _title += " (" + entry.createddate + ") ";


                if(entry.entry_done == 1){
                    _title += '<span class="badge badge-pill badge-success tagged">'+getWord("files","entry_done")+'</span>';
                }
                if(entry.need_follow_up_treatment == 1){
                    _title += '<span class="badge badge-pill badge-warning tagged">'+getWord("files","post_treatment")+'</span>';
                }

                content = '<div class = "form-row">';


                if(entry.entry_done == 0){
                    if(checkAllowed("file_entries","close")){
                        content += DaBurnerGermany.Button({
                            id:""
                            ,text:getWord("global","complete")
                            ,onclick:"files_entry_complete("+entry.uid+")"
                            ,cls:[
                                "btn-success"
                                ,"btn-sm"
                                ,"btn-block"
                                ,"btn-marginright"
                            ]
                            ,width:3
                            ,disabled:false
                        });
                    }
                }
                
                
                if(checkAllowed("file_entries","close")){
                    content += DaBurnerGermany.Button({
                        id:""
                        ,text:getWord("global","delete")
                        ,onclick:"files_entry_delete("+entry.uid+")"
                        ,cls:[
                            "btn-danger"
                            ,"btn-sm"
                            ,"btn-block"
                            
                        ]
                        ,width:3
                        ,disabled:false
                    });
                }

                content += '</div>';
                content +="<h5>"+getWord("global",'information') + "</h5>";
                content += entry.entry_content;

                if(entry.intensity_of_wounds !== null || entry.intensity_of_wounds !== null){
                    content += "<p></p>"
                    content +="<h5>"+getWord("files",'injury_types') + "</h5>";

                    let temp = "";

                    if(entry.intensity_of_wounds !== null){
                        temp += (temp == "" ? "" : "<br><br>");
                        temp += getWord("columns",'intensity_of_wounds') + ":<br>"
                        temp += entry.intensity_of_wounds;
                    }
    
                    if(entry.intensity_of_wounds !== null){
                        temp += (temp == "" ? "" : "<br><br>");
                        temp += getWord("columns",'type_of_bleeding') + ":<br>"
                        temp += entry.type_of_bleeding;
                    }

                    content += temp;
                }

                if(entry.treatment !== null){
                    content += "<p></p>"
                    content +="<h5>"+getWord("columns",'treatment') + "</h5>";
                    content += entry.treatment;
                }


                let injury_table = [
                    ["","head",""]
                    ,["","neck",""]
                    ,["left_arm","torso","right_arm"]
                    ,["","stomach",""]
                    ,["left_leg","hip","right_leg"]
                    ,["left_foot","","right_foot"]
                ]

                let given_injuries = [
                    'head'
                    ,'hip'
                    ,'left_arm'
                    ,'left_foot'
                    ,'left_leg'
                    ,'neck'
                    ,'right_arm'
                    ,'right_foot'
                    ,'right_leg'
                    ,'stomach'
                    ,'torso'

                ];

                let showExistingInjuries = false;

                for(var j=0; j < given_injuries.length; j++){
                    if(entry["injury_"+given_injuries[j]] !== null){
                        showExistingInjuries = true;
                    }
                }

                if(showExistingInjuries){
                    content += "<p></p>"
                    content +="<h5>"+getWord("files",'existing_injuries') + "</h5>";
                    content+='<table class = "table-dark">';
                    
                    for(var j=0; j < injury_table.length; j++){
                        content += '<tr>';

                        for(var k=0; k<injury_table[j].length; k++){
                            if(injury_table[j][k] !== ""){
                                content += '<td style = "width:33%; text-align:center;border:1px solid white ">';

                                content += getWord("injuries",injury_table[j][k])+":<br>";
                                if(entry["injury_"+injury_table[j][k]] == null){
                                    content += "-";
                                }
                                else{
                                    content += entry["injury_"+injury_table[j][k]];
                                }
                                
                            
                            }
                            
                            else{
                                
                                content += '<td style = "width:33%;">';
                                content+="";
                            }
                            content += "</td>";
                        }

                        
                        
                        content += "</td>";
                        
                        content += "</tr>";
                    }


                    content+='</table>';

                }

                
                



                DaBurnerGermany.AddToBody(
                    DaBurnerGermany.FieldSet({
                        id:""
                        ,title:_title
                        ,startCollapsed:true
                        ,collapsible:true
                        ,colorscheme:"dark"
                        ,items:[
                            content
                        ] 
                    })
                );

            }
        }
    }



    /*
    if(data.entries !== undefined){
        if(data.entries.values !== undefined){

            let lastColumnIdx = 0;
            let resultData={
                data:[]
                ,header:[
                    "file_entries_0"
                    ,"file_entries_1"
                ]
            };


            for(var i=0; i < data.entries.values.length;i++){    
                
                
                

                let content = "";

                content = JSON.stringify(data.entries.values[i]);      


                resultData.data[i]=[];
                resultData.data[i][lastColumnIdx] = {
                    "id":"file_entries_" + lastColumnIdx
                    ,"value":content
                }
                

                if(lastColumnIdx == 0){
                    lastColumnIdx = 1;
                }
                else{
                    lastColumnIdx = 0;
                }             
                
                resultData.data[i][lastColumnIdx] = {
                    "id":"file_entries_" + lastColumnIdx
                    ,"value":""
                }
            }


            DaBurnerGermany.AddToBody(
                DaBurnerGermany.FieldSet({
                    id:""
                    ,title:getWord("files","title_file_entries")
                    ,startCollapsed:false
                    ,collapsible:true
                    ,colorscheme:"dark"
                    ,items:[
                        DaBurnerGermany.Grid({
                            id:"file_entries"
                            ,columns:convertTableHeader(resultData.header)
                            ,tabledata:resultData.data
                            ,renderer:{
                                "file_entries_0":"renderer_file_entries"
                                ,"file_entries_1":"renderer_file_entries"
                            }
                            ,cls:["table-dark"]
                            ,clsTableHead:[]
                            ,clsTableBody:["tbody-white"]
                            ,needsCount:false
                            ,allowQuicksearch:false  
                            ,showHeader:false  
                        })
                    ]
                })
            );
        }


    }
    */
    
}

function additionalData_radio(data){
    if(data){
        let content = "";

        if(data.radio.Patrol_ID >= 0){
            content += getWord("radio","current_status_of_patrol");
        }
        else{
            content += getWord("radio","current_status_of_user");
        }
        content += " <strong>"+ data.radio.StatusName +"</strong>"
        
        if(data.radio.Patrol_ID >= 0){
            content += "<br>" + getWord("radio","current_patrol");
            content += " <strong>"+ data.radio.PatrolName +"</strong>"
        }


        setAlertField("id_alertinfo", content, true,"primary");
        
        DBG.setDisabled("patrol_service_end_by_user",data.radio.DisableEndService == "1");
        DBG.setDisabled("patrol_leave_by_user",data.radio.DisableLeavePatrol == "1");
    
    }
    else{
        DBG.setDisabled("patrol_service_end_by_user",true);
        DBG.setDisabled("patrol_leave_by_user",true);
    }  
}

function additionalData_control_centre(data){
    let content = "";    
        
    let infocontent = "";
    let alertColorType = ""

    let allowControlCentreTake = checkAllowed("control_centre","take");

    if(data.control_centre.control_centre_isset == 0){
        alertColorType = "danger";
        infocontent += "<strong>" + getWord("control_centre","none")+"</strong><br>" ;
        if(allowControlCentreTake){

            infocontent += DaBurnerGermany.Button({
                id:""
                ,text:getWord("control_centre","take")
                ,onclick:"control_centre_set_by_user()"
                ,cls:[
                    "btn-warning"
                    ,"btn-sm"
                ]
                ,width:0
                ,disabled:false
            });
        }
    }
    else{
        infocontent += getWord("control_centre","current");
        infocontent += " <strong>"+ data.control_centre.control_centre_name +"</strong>"

        if(allowControlCentreTake){

            infocontent += DaBurnerGermany.Button({
                id:""
                ,text:getWord("control_centre","reset")
                ,onclick:"control_centre_reset()"
                ,cls:[
                    "btn-danger"
                    ,"btn-sm"
                ]
                ,width:3
                ,disabled:false
            });
            if(data.control_centre.control_centre_self == 0){

                infocontent += DaBurnerGermany.Button({
                    id:""
                    ,text:getWord("control_centre","current_control_take")
                    ,onclick:"control_centre_set_by_user()"
                    ,cls:[
                        "btn-warning"
                        ,"btn-sm"
                    ]
                    ,width:3
                    ,disabled:false
                });
            }
        }
    }
    
    setAlertField("id_alertinfo", infocontent, true,alertColorType);


    content += "<h3>";
    content += getWord("global","patrols");
    content += "</h3>";
    if(checkAllowed("control_centre", "reset_patrols")){

        content += DaBurnerGermany.Button({
            id:""
            ,text:getWord("control_centre","patrol_reset_all")
            ,onclick:"patrol_reset('*')"
            ,cls:[
                "btn-primary"
                ,"btn-sm"
            ]
            ,width:3
            ,disabled:false
        });
    }

    content += DaBurnerGermany.Grid({
        id:"file_licenses"
        ,columns:convertTableHeader(data.patrols.header)
        ,tabledata:data.patrols.values
        ,renderer:{
            "patrols_name":"renderer_color"
            ,"patrols_shortname_tableheader":"renderer_color"
            ,"patrol_officers":"renderer_color"
            ,"patrol_status":"renderer_color"
            ,"patrol_status_info":"renderer_color"
            ,"patrol_area":"renderer_color"
            ,"patrol_vehicle":"renderer_color"
            ,"uid":"renderer_PatrolActions"
        }
        ,cls:["table-dark","table-sm"]
        ,clsTableHead:[]
        ,clsTableBody:["tbody-white"]
        ,needsCount:false
        ,allowQuicksearch:false  
    })

    content += "<h3>";
    content += getWord("pageloader","officers");
    content += "</h3>";

    DaBurnerGermany.widenContainer();

    DaBurnerGermany.AddToBodyTop(content);    
}

function additionalData_custom_personal_file(data){

    getExtraButtonsBottom(globalPageLoaderJson.extraButtons);

    DaBurnerGermany.create();



    
    DaBurnerGermany.AddToTitle(" - " + data.officername.officer_name);

    
    
    if(data.entries !== undefined){
        if(data.entries.values !== undefined){

            let lastColumnIdx = 0;
            let resultData={
                data:[]
                ,header:[
                    "file_entries_0"
                    ,"file_entries_1"
                ]
            };


            for(var i=0; i < data.entries.values.length;i++){    
                
                
                

                let content = "";
                content = JSON.stringify(data.entries.values[i]);      


                resultData.data[i]=[];
                resultData.data[i][lastColumnIdx] = {
                    "id":"file_entries_" + lastColumnIdx
                    ,"value":content
                }
                

                if(lastColumnIdx == 0){
                    lastColumnIdx = 1;
                }
                else{
                    lastColumnIdx = 0;
                }             
                
                resultData.data[i][lastColumnIdx] = {
                    "id":"file_entries_" + lastColumnIdx
                    ,"value":""
                }
            }


            DaBurnerGermany.AddToBody(
                DaBurnerGermany.Grid({
                    id:""
                    ,columns:convertTableHeader(resultData.header)
                    ,tabledata:resultData.data
                    ,renderer:{
                        "file_entries_0":"renderer_personalfile_entries"
                        ,"file_entries_1":"renderer_personalfile_entries"
                    }
                    ,cls:["table-dark"]
                    ,clsTableHead:[]
                    ,clsTableBody:["tbody-white"]
                    ,needsCount:false
                    ,allowQuicksearch:false  
                    ,showHeader:false  
                })
            );
        }


    }
}

function additionalData_view_criminal_complaints_byfile_0(data){
    DaBurnerGermany.AddToBodyTop(
        DaBurnerGermany.Button({
            id:""
            ,text:getWord("global","navigate_back")
            ,onclick:"doLoadPageContent('form_files','view',"+lastRequested["id"]+")"
            ,cls:[
                "btn-warning"
            ]
            ,width:3
            ,disabled:false
        })
    );
}

function additionalData_settings(data){

    let cards = {
        0:{"name":"usersettings","gotopage" : "form_usersettings","viewType":"edit", "colortype":"danger","allowed":1}
        ,1:{"name":"resetpassword","gotopage" : "form_resetpassword","viewType":"edit", "colortype":"warning","allowed":1}
        ,2:{"name":"group_management_settings","gotopage" : "group_management","viewType":"", "colortype":"primary","allowed":checkAllowed("group_management","view")}
    };

    let content = "";
    for(var i = 0; i < Object.keys(cards).length;i++){
        if(cards[i].allowed == 1){
            DaBurnerGermany.AddToBody(
                DaBurnerGermany.Button({
                    id:""
                    ,text:getWord("global",cards[i].name)
                    ,onclick:"doLoadPageContent('"+cards[i].gotopage+"','"+cards[i].viewType+"',-1)"
                    ,cls:[
                        "btn-"+cards[i].colortype
                        ,"btn-large"
                        ,"btn-settings-card"
                    ]
                    ,width:0
                    ,disabled:false
                })
            );
        }
    }
}


function additionalData_form_passwordreset_foruser(data){
    DaBurnerGermany.AddToBody(
        DaBurnerGermany.TextField({
            id:"id_new_password"
            ,type:"password"
            ,fieldLabel:getWord("password","password")
            ,cls:[]
            ,hidden:false
            ,width:0
            ,height:0
            ,onKeyup:"checkIfPasswordFieldsValid()"
            ,allowBlank:false
            ,readOnly:false
            ,disabled:false
            ,value:""
        })
    );
    DaBurnerGermany.AddToBody(
        DaBurnerGermany.TextField({
            id:"id_new_password_confirm"
            ,type:"password"
            ,fieldLabel:getWord("password","confirm_password")
            ,cls:[]
            ,hidden:false
            ,width:0
            ,height:0
            ,onKeyup:"checkIfPasswordFieldsValid()"
            ,allowBlank:false
            ,readOnly:false
            ,disabled:false
            ,value:""
        })
    );


    DaBurnerGermany.AddToBody(
        DaBurnerGermany.CompositeField({
            items:[
                DaBurnerGermany.Button({
                    id:""
                    ,text:getWord("global","cancel")
                    ,onclick:"doLoadPageContent('form_officer','view',"+lastRequested["id"]+")"
                    ,cls:[
                        "btn-danger"
                        ,"btn-block"
                    ]
                    ,width:6
                    ,disabled:false
                }),
                DaBurnerGermany.Button({
                    id:"savePassword"
                    ,text:getWord("global","save")
                    ,onclick:"password_reset('form_officer',"+lastRequested["id"]+")"
                    ,cls:[
                        "btn-success"
                        ,"btn-block"
                    ]
                    ,width:6
                    ,disabled:true
                })
            ]
        })        
    );
}
function additionalData_form_resetpassword(data){
    DaBurnerGermany.AddToBody(
        DaBurnerGermany.TextField({
            id:"id_new_password"
            ,type:"password"
            ,fieldLabel:getWord("password","password")
            ,cls:[]
            ,hidden:false
            ,width:0
            ,height:0
            ,onKeyup:"checkIfPasswordFieldsValid()"
            ,allowBlank:false
            ,readOnly:false
            ,disabled:false
            ,value:""
        })
    );
    DaBurnerGermany.AddToBody(
        DaBurnerGermany.TextField({
            id:"id_new_password_confirm"
            ,type:"password"
            ,fieldLabel:getWord("password","confirm_password")
            ,cls:[]
            ,hidden:false
            ,width:0
            ,height:0
            ,onKeyup:"checkIfPasswordFieldsValid()"
            ,allowBlank:false
            ,readOnly:false
            ,disabled:false
            ,value:""
        })
    );
    DaBurnerGermany.AddToBody(
        DaBurnerGermany.CompositeField({
            items:[
                DaBurnerGermany.Button({
                    id:""
                    ,text:getWord("global","cancel")
                    ,onclick:"doLoadPageContent('settings','',-1)"
                    ,cls:[
                        "btn-danger"
                        ,"btn-block"
                    ]
                    ,width:6
                    ,disabled:false
                }),
                DaBurnerGermany.Button({
                    id:"savePassword"
                    ,text:getWord("global","save")
                    ,onclick:"password_reset('settings',-1)"
                    ,cls:[
                        "btn-success"
                        ,"btn-block"
                    ]
                    ,width:6
                    ,disabled:true
                })
            ]
        })        
    );
}

function additionalData_dashboard(data){

    if(data !== undefined){
        if(data.overview !== undefined){
            if(data.overview.values !== undefined){

                DaBurnerGermany.AddToBody(
                    DaBurnerGermany.PortalRow({
                        id:""
                        ,items:[
                            {
                                width:4
                                ,title:getWord("dashboard","count_files")
                                ,items:[
                                    {
                                        value:data.overview.values[0].count_files_total
                                        ,description:getWord("dashboard","includes_deleted")
                                    }
                                ]
                            },
                            {
                                width:4
                                ,title:getWord("dashboard","count_files_currently")                       
                                ,items:[
                                    {
                                        value:data.overview.values[0].count_files
                                        ,description:""
                                    }
                                ]
                            },
                            {
                                width:4
                                ,title:getWord("dashboard","current_control_centre")                       
                                ,items:[
                                    {
                                        value:(data.overview.values[0].control_centre === null? getWord("dashboard","current_control_centre_none") : data.overview.values[0].control_centre )
                                        ,description: (data.overview.values[0].control_centre === null? "" : data.overview.values[0].control_centre_fullname )
                                    }
                                ]
                            }
                        ]
                    })
                );

                DaBurnerGermany.AddToBody(
                    DaBurnerGermany.PortalRow({
                        id:""
                        ,items:[
                            {
                                width:8
                                ,title:getWord("dashboard","created_datasets")
                                ,items:[
                                    {
                                        value:data.overview.values[0].total_created_month
                                        ,description:getWord("dashboard","last_week")
                                    },
                                    {
                                        value:data.overview.values[0].total_created_week
                                        ,description:getWord("dashboard","last_month")
                                    }
                                ]
                            },
                            {
                                width:4
                                ,title:getWord("dashboard","officer_in_duty")                       
                                ,items:[
                                    {
                                        value:data.overview.values[0].count_officer_in_duty 
                                        ,description: ""
                                    }
                                ]
                            }
                            
                        ]
                    })
                );

            }
        }
    }
}
