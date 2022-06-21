function getFieldsByArray(formCfg){
    let fields = createFieldArrayByConfig(formCfg);

    for(var i = 0 ; i<fields.length;i++){

        let rowItems = [];

        let columnMD = Math.floor(12/fields[i].length);
        for(var j =0; j < fields[i].length;j++){
            rowItems.push(getField(fields[i][j],"",columnMD));
        }

        DaBurnerGermany.addElement(
            DaBurnerGermany.CompositeField({
                items:rowItems
            })
        );
    }
}


function getAlertBox(fieldName, alerttype){
    let content = '<div class="alert alert-'+alerttype+'" role="alert" style="display:block; width:100%;" id="id_'+fieldName+'">'
    content += ''
    content += '</div>';

    return content;
}

function replaceEmptyChar(input){
    return input.replace(/ /g,"");
}

function checkIfNotEmpty(input){
    return replaceEmptyChar(input) != "";
}


function handleAddButton(ButtonCfg){
    if(DaBurnerGermany.getPageType() == "table" || DaBurnerGermany.getPageType()=="custom"){
        if(ButtonCfg !== undefined){
            if(checkIfNotEmpty(ButtonCfg.goto_functionname)){
                DaBurnerGermany.addElement(
                    DaBurnerGermany.Button({
                        id:""
                        ,text:getWord("global","add_entry")
                        ,onclick:"doLoadPageContent('"+ButtonCfg.goto_functionname+"','add',-1)"
                        ,cls:[
                            "btn-success"
                        ]
                        ,width:0
                        ,disabled:false
                    })
                );
            }
        }
    }
}



function getExtraButtonsBottom(ButtonConfigs){
    let buttons=[]

    if(ButtonConfigs !== undefined){
        let colMD = Math.floor(12/ButtonConfigs.length);

        for(var i=0; i<ButtonConfigs.length;i++){
            let value_by = ButtonConfigs[i].value_field;
            if(value_by != ""){
                value_by = 'valueby_id_'+value_by;
            }

            buttons.push(
                DaBurnerGermany.Button({
                    id:ButtonConfigs[i].button_name
                    ,text:getWord("extrabutton",ButtonConfigs[i].label)
                    ,onclick:ButtonConfigs[i].onclickevent.replace(/"/g,"'").replace("@@lastRequestedID@@",lastRequested["id"])
                    ,cls:[
                        "btn-"+ButtonConfigs[i].btncolor
                        ,"btn-block"
                        ,value_by
                    ]
                    ,width:colMD
                    ,disabled:ButtonConfigs[i].default_disabled
                })
            );
        }

        if(buttons.length > 0){    
            DaBurnerGermany.addElement(
                DaBurnerGermany.CompositeField({
                    items:buttons
                })
            );
        }
    }
}

function getBtnPageCfg(Button){
    let retval = [];
    retval["destination"] = ""; 
    retval["loadType"] = ""; 
    retval["id2load"] = ""; 

    if(Button !== undefined){
        if(replaceEmptyChar(Button.goto_functionname) !== ""){
            retval["destination"] = Button.goto_functionname; 
            retval["loadType"] = Button.goto_functiontype; 
            retval["id2load"] = -1; 

            if(lastRequested["id"] > -1){
                if(replaceEmptyChar(Button.goto_functionname_idDefined) !== ""){    
                    retval["destination"] = Button.goto_functionname_idDefined; 
                    retval["loadType"] = Button.goto_functiontype_idDefined; 
                    retval["id2load"] = lastRequested["id"]; 
                }
            }
        }
    }
    return retval;
}



function getTableButtonsTop(BackButton){

    let pageCfg = getBtnPageCfg(BackButton);

    if(pageCfg["destination"] !== ""){

        DaBurnerGermany.addElement(
            DaBurnerGermany.Button({
                id:"id_global_back"
                ,text:getWord("global","navigate_back")
                ,onclick:"doLoadPageContent('"+pageCfg["destination"]+"','"+pageCfg["loadType"]+"',"+pageCfg["id2load"]+")"
                ,cls:[
                    "btn-warning"
                    ,"btn-block"
                ]
                ,width:3
                ,disabled:false
            })
        );
    }    
}

function getFormButtonsTop(BackButton, EditButton){
    let colMD = 3;

    let buttons=[];
    
    if(BackButton !== undefined){
        if(replaceEmptyChar(BackButton.goto_functionname) !== ""){
            buttons.push(
                DaBurnerGermany.Button({
                    id:"id_global_back"
                    ,text:getWord("global","navigate_back")
                    ,onclick:"doLoadPageContent('"+BackButton.goto_functionname+"','',-1)"
                    ,cls:[
                        "btn-danger"
                        ,"btn-block"
                    ]
                    ,width:colMD
                    ,disabled:false
                })
            );
        }
    }

    if(EditButton !== undefined){
        if(replaceEmptyChar(EditButton.goto_functionname) !== ""){
            buttons.push(
                DaBurnerGermany.Button({
                    id:"id_global_edit"
                    ,text:getWord("global","edit")
                    ,onclick:"doLoadPageContent('"+EditButton.goto_functionname+"','edit',"+lastRequested["id"]+")"
                    ,cls:[
                        "btn-warning"
                        ,"btn-block"
                    ]
                    ,width:colMD
                    ,disabled:false
                })
            );
        }

    }

    if(buttons.length > 0){    
        DaBurnerGermany.addElement(
            DaBurnerGermany.CompositeField({
                items:buttons
            })
        );
    }
}

function getFormButtonsBottom(previousPage, allowSave){
    let colMD = 12;
    let divider = 0;
    let buttons=[];

    if(previousPage !== undefined){
        if(replaceEmptyChar(previousPage.goto_functionname) !== ""){
            divider++;
            if(allowSave){
                divider++;
            }
        }
    }
    colMD = Math.floor(colMD/divider);


    if(previousPage !== undefined ){
        if(replaceEmptyChar(previousPage.goto_functionname) !== ""){
            buttons.push(
                DaBurnerGermany.Button({
                    id:""
                    ,text:getWord("global","cancel")
                    ,onclick:"doLoadPageContent('"+previousPage.goto_functionname+"','view',-1)"
                    ,cls:[
                        "btn-danger"
                        ,"btn-block"
                    ]
                    ,width:colMD
                    ,disabled:false
                })
            );
    
            if(allowSave){
    
                buttons.push(
                    DaBurnerGermany.Button({
                        id:"save"
                        ,text:getWord("global","save")
                        ,onclick:"saveData('"+ previousPage.button +"')"
                        ,cls:[
                            "btn-success"
                            ,"btn-block"
                        ]
                        ,width:colMD
                        ,disabled:true
                    })
                );
            }
        }
    }
    if(buttons.length > 0){    
        DaBurnerGermany.addElement(
            DaBurnerGermany.CompositeField({
                items:buttons
            })
        );
    }
}