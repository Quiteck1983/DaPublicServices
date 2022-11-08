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
function additionalData_form_files(data){
    DaBurnerGermany.AddToTitle(" - " + data.information.file_number);
    if(data.is_wanted !== undefined){
        if(data.is_wanted.file_entry_id !== undefined){
            let buttoncontent = $("#id_global_back").parent().parent()[0].outerHTML;
            $("#id_global_back").parent().parent().remove();
        
        
            
            let endWantingButton = "";
            if(checkAllowed("manhunt","end")){
                endWantingButton= DaBurnerGermany.Button({
                    id:""
                    ,text:getWord("manhunt","end_is_wanted")
                    ,onclick:"files_manhunt_end("+data.is_wanted.file_entry_id+")"
                    ,cls:[
                        "btn-primary"
                        ,"btn-sm"
                    ]
                    ,width:0
                    ,disabled:false
                })
            }

            if(endWantingButton != ""){
                endWantingButton = "<br><br>"+endWantingButton;
            }
            
        
            DaBurnerGermany.AddToBodyTop(
                buttoncontent+
                '<div class="alert alert-danger" role="alert" id="id_alert_wanted">'
                +"<h4>" + getWord("manhunt","is_wanted")+"</h4>"
                +"<strong>" + getWord("manhunt","person_is_wanted_by")+"</strong>" + " " + data.is_wanted.wanted_by + "<br>"
                +"<strong>" + getWord("manhunt","wanted_since")+"</strong>" + " " + data.is_wanted.wanted_since + "<br><br>"
                +"<strong>" + getWord("global","information")+"</strong><br>" + data.is_wanted.reason_of_wanting
                +endWantingButton
                +'</div>'
            );
        }
    }

    let fsitems=[];

    if(checkAllowed("file_licenses","grant")){
        if(data.available_licenses.values !== undefined){
            if(data.available_licenses.values.length > 0){
                fsitems.push(
                    DaBurnerGermany.CompositeField({
                        items:[
                            DaBurnerGermany.ComboBox({
                                id:"id_available_licenses"
                                ,fieldLabel:""
                                ,cls:[]
                                ,hidden:false
                                ,width:9
                                ,height:0
                                ,onchange:"checkIfFormIsValid(true)"
                                ,allowBlank:true
                                ,readOnly:false
                                ,disabled:false
                                ,value:""
                                ,data:data.available_licenses.values   
                            }),
                            DaBurnerGermany.Button({
                                id:"id_available_licenses_add"
                                ,text:getWord("files","add_license_to_file")
                                ,onclick:"files_grant_license()"
                                ,cls:[
                                    "btn-success"
                                    ,"btn-block"
                                ]
                                ,width:3
                                ,disabled:false
                            })
                        ]
                    })
                
                );
            }
        }
    }

    if(data.given_licenses.values.length > 0){
        fsitems.push(
            DaBurnerGermany.Grid({
                id:"file_licenses"
                ,columns:convertTableHeader(data.given_licenses.header)
                ,tabledata:data.given_licenses.values
                ,renderer:{
                    "uid":"renderer_removeLicenses"
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
        fsitems.push("<p>"+getWord("files","no_licenses_granted")+"</p>");
    }

    DaBurnerGermany.AddToBody(
        DaBurnerGermany.FieldSet({
            id:"FieldSet_LicenseOverview"
            ,title:getWord("files","overview_all_licenses")
            ,startCollapsed:false
            ,collapsible:true
            ,colorscheme:"dark"
            ,items:fsitems 
        })
    );

    DaBurnerGermany.AddToBody(
        DaBurnerGermany.FieldSet({
            id:"FieldSet_Complaints"
            ,title:getWord("files","criminal_complaints_overview")
            ,startCollapsed:false
            ,collapsible:true
            ,colorscheme:"dark"
            ,items:[
                DaBurnerGermany.Grid({
                    id:"file_complaints"
                    ,columns:convertTableHeader(data.count_complaints.header)
                    ,tabledata:data.count_complaints.values
                    ,renderer:{
                        "reporter":"renderer_file_complaints_overview_reporter"
                        ,"unedited":"renderer_file_complaints_overview_1"
                        ,"in_progress":"renderer_file_complaints_overview_2"
                        ,"closed":"renderer_file_complaints_overview_3"
                    }
                    ,cls:["table-dark"]
                    ,clsTableHead:[]
                    ,clsTableBody:["tbody-white"]
                    ,needsCount:false
                    ,allowQuicksearch:false  
                })
            ]
        })
    );



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
    content += getWord("global","officers");
    content += "</h3>";

    DaBurnerGermany.widenContainer();

    DaBurnerGermany.AddToBodyTop(content);    
}

function additionalData_form_investigation(data){
    DaBurnerGermany.AddToBody(
        DaBurnerGermany.Grid({
            id:"investigation_entries_table"
            ,columns:convertTableHeader(data.entries.header)
            ,tabledata:data.entries.values
            ,renderer:{
                "is_important_entry":"renderer_importantEntry"
            }
            ,cls:["table-dark","table-sm"]
            ,clsTableHead:[]
            ,clsTableBody:["tbody-white"]
            ,needsCount:false
            ,allowQuicksearch:false  
        })
    );
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

function additionalData_law_book(data){
    handleAddButton(globalPageLoaderJson.function_buttons.addButton);

    if(data.penalties !== undefined){
        if(data.penalties.values !== undefined){
            let lastLawBookID = undefined;
            let resultData=[];
            let CurrentIndex = -1;
            for(var i=0; i < data.penalties.values.length;i++){                
                if(lastLawBookID != data.penalties.values[i].lawbook_uid){
                    CurrentIndex++;
                    resultData[CurrentIndex] = {                        
                        lawbookid:data.penalties.values[i].lawbook_uid
                        ,lawbookname:data.penalties.values[i].lawbook_name
                        ,data:[]
                        ,header:[
                            "crime"
                            ,"minimum_penalty"
                            ,"detention_time"
                            ,"road_traffic_regulations_points"
                            ,"others"
                            ,"uid"
                        ]
                    };
                    lastLawBookID = data.penalties.values[i].lawbook_uid;
                }

                if(data.penalties.values[i].law_uid!==null){
                    let row=[
                        {"id":"crime", "value":data.penalties.values[i].crime}
                        ,{"id":"minimum_penalty", "value":data.penalties.values[i].minimum_penalty}
                        ,{"id":"detention_time", "value":data.penalties.values[i].detention_time}
                        ,{"id":"road_traffic_regulations_points", "value":data.penalties.values[i].road_traffic_regulations_points}
                        ,{"id":"others", "value":data.penalties.values[i].others}
                        ,{"id":"uid", "value":data.penalties.values[i].law_uid}
                    ];
                    resultData[CurrentIndex].data.push(row);
                }   
            }
            for(var i=0; i<resultData.length;i++){
                DaBurnerGermany.addElement('<p></p>')
                DaBurnerGermany.addElement(
                    DaBurnerGermany.FieldSet({
                        id:""
                        ,title:resultData[i].lawbookname
                        ,startCollapsed:true
                        ,collapsible:true
                        ,colorscheme:"dark"
                        ,items:[
                            DaBurnerGermany.CompositeField({
                                items:[
                                    DaBurnerGermany.Button({
                                        id:""
                                        ,text:getWord("pageloader","form_crimes_add")
                                        ,onclick:"doLoadPageContent('form_crimes','add',-1)"
                                        ,cls:[
                                            "btn-success"
                                            ,"btn-block"
                                            ,"btn-sm"
                                        ]
                                        ,width:6
                                        ,disabled:false
                                    }),
                                    DaBurnerGermany.Button({
                                        id:""
                                        ,text:getWord("lawbook","edit")
                                        ,onclick:"doLoadPageContent('form_lawbook','edit',"+resultData[i].lawbookid+")"
                                        ,cls:[
                                            "btn-warning"
                                            ,"btn-block"
                                            ,"btn-sm"
                                        ]
                                        ,width:3
                                        ,disabled:false
                                    }),
                                    DaBurnerGermany.Button({
                                        id:""
                                        ,text:getWord("global","delete")
                                        ,onclick:"showDeleteConfirm("+resultData[i].lawbookid+",'')"
                                        ,cls:[
                                            "btn-danger"
                                            ,"btn-block"
                                            ,"btn-sm"
                                        ]
                                        ,width:3
                                        ,disabled:false
                                    }),
                                    
                                    DaBurnerGermany.Grid({
                                        id:"file_licenses"
                                        ,columns:convertTableHeader(resultData[i].header)
                                        ,tabledata:resultData[i].data
                                        ,renderer:{
                                            "crime":"renderer_paragraph"
                                            ,"uid":"renderer_lawbooklaws_actions"
                                        }
                                        ,cls:["table-dark"]
                                        ,clsTableHead:[]
                                        ,clsTableBody:["tbody-white"]
                                        ,needsCount:false
                                        ,allowQuicksearch:false  
                                    })
                                

                                ]
                            })
                        ]
                    })
                )
            }
        }


    }

    DaBurnerGermany.create()
    
}

function additionalData_form_files_add_entry(data){

    let TempObj = [];

    if(data.penalties !== undefined){
        if(data.penalties.values !== undefined){
            let lastLawBookID = undefined;
            let resultData=[];
            let CurrentIndex = -1;
            for(var i=0; i < data.penalties.values.length;i++){                
                if(lastLawBookID != data.penalties.values[i].lawbook_uid){
                    CurrentIndex++;
                    resultData[CurrentIndex] = {                        
                        lawbookid:data.penalties.values[i].lawbook_uid
                        ,lawbookname:data.penalties.values[i].lawbook_name
                        ,data:[]
                        ,header:[
                            "crime"
                            ,"uid"
                        ]
                    };
                    lastLawBookID = data.penalties.values[i].lawbook_uid;
                }

                if(data.penalties.values[i].law_uid!==null){
                    let row=[
                        {"id":"crime", "value":data.penalties.values[i].crime}
                        ,{"id":"uid", "value":data.penalties.values[i].law_uid}
                    ];
                    resultData[CurrentIndex].data.push(row);
                }
            }

            


            for(var i=0; i<resultData.length;i++){
                if(resultData[i].data.length>0){
                    TempObj.push('<p></p>')
                    TempObj.push(
                        DaBurnerGermany.FieldSet({
                            id:""
                            ,title:resultData[i].lawbookname
                            ,startCollapsed:true
                            ,collapsible:true
                            ,colorscheme:"dark"
                            ,items:[
                                DaBurnerGermany.CompositeField({
                                    items:[                            
                                        DaBurnerGermany.Grid({
                                            id:""
                                            ,columns:convertTableHeader(resultData[i].header)
                                            ,tabledata:resultData[i].data
                                            ,renderer:{
                                                "crime":"renderer_paragraph"
                                                ,"uid":"renderer_numberFieldLawBookGrid"
                                            }
                                            ,cls:["table-dark"]
                                            ,clsTableHead:[]
                                            ,clsTableBody:["tbody-white"]
                                            ,needsCount:false
                                            ,allowQuicksearch:false  
                                        })
                                    ]
                                })
                            ]
                        })
                    )
                }
            }
        }
    }

    DaBurnerGermany.AddToBody(TempObj.join(""))
    
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

function additionalData_view_criminal_complaints_byfile_1(data){
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
function additionalData_view_criminal_complaints_byfile_2(data){
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
function additionalData_view_criminal_complaints_byfile_3(data){
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
        ,2:{"name":"license_settings","gotopage" : "licenses","viewType":"", "colortype":"info","allowed":checkAllowed("licenses","view")}
        ,3:{"name":"group_management_settings","gotopage" : "group_management","viewType":"", "colortype":"primary","allowed":checkAllowed("group_management","view")}
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

function additionalData_form_vehicle(data){

    if(data.wanted !== undefined){
        if(data.wanted.is_wanted !== undefined && data.wanted.reason_of_is_wanted !== undefined){
            if(data.wanted.is_wanted == 1){
                let buttoncontent = $("#id_global_back").parent().parent()[0].outerHTML;
                $("#id_global_back").parent().parent().remove();
    
                let endWantingButton = "";
                if(checkAllowed("manhunt","end")){
                    endWantingButton= DaBurnerGermany.Button({
                        id:""
                        ,text:getWord("manhunt","end_is_wanted")
                        ,onclick:"registered_vehicle_reset_wanting("+lastRequested["id"]+")"
                        ,cls:[
                            "btn-primary"
                            ,"btn-sm"
                        ]
                        ,width:0
                        ,disabled:false
                    });
                }
    
                if(endWantingButton != ""){
                    endWantingButton = "<br><br>" + endWantingButton;
                }
    
                let Reason = getReasonIfIsWanted(data.wanted.reason_of_is_wanted);
            
                
                DaBurnerGermany.AddToBodyTop(
                    buttoncontent+
                    '<div class="alert alert-danger" role="alert" id="id_alert_wanted">'
                    +"<h4>" + getWord("manhunt","is_wanted")+"</h4>"
                    +Reason
                    +endWantingButton
                    +'</div>'
                );    
            }
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
                                ,title:getWord("dashboard","count_vehicles")
                                ,items:[
                                    {
                                        value:data.overview.values[0].count_vehicles
                                        ,description:""
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
                                width:4
                                ,title:getWord("dashboard","current_control_centre")                       
                                ,items:[
                                    {
                                        value:(data.overview.values[0].control_centre === null? getWord("dashboard","current_control_centre_none") : data.overview.values[0].control_centre )
                                        ,description: (data.overview.values[0].control_centre === null? "" : data.overview.values[0].control_centre_fullname )
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
                            },
                            {
                                width:4
                                ,title:getWord("dashboard","count_officers")                       
                                ,items:[
                                    {
                                        value:data.overview.values[0].count_officers 
                                        ,description: ""
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
                            }
                            
                        ]
                    })
                );

                DaBurnerGermany.AddToBody(
                    DaBurnerGermany.PortalRow({
                        id:""
                        ,items:[
                            {
                                width:4
                                ,title:getWord("dashboard","count_manhunt")
                                ,items:[
                                    {
                                        value:data.overview.values[0].count_manhunt
                                        ,description:""
                                    }
                                ]
                            },
                            {
                                width:4
                                ,title:getWord("dashboard","count_open_investigations")                       
                                ,items:[
                                    {
                                        value:data.overview.values[0].count_open_investigations 
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
