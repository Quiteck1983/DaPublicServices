function doLoadRequiredData(){
    let type = globalPageLoaderJson.functionconfig.function_name;
    let doLoadData = globalPageLoaderJson.functionconfig.doLoaddata;
    let doLoadData_WithoutID = globalPageLoaderJson.functionconfig.doLoadData_NoID;
    let loadType = globalPageLoaderJson.functionconfig.type;

    let LoadAllowed = doLoadData;

    if(doLoadData == 1){
        if(loadType == "form" && lastRequested["id"] == -1 && doLoadData_WithoutID == 0){
            LoadAllowed = false;
        }
    }
    
    if(loadType == "table"){
        totalRowsForQuery = 0;
    }

    
    resetAlert();

    if(LoadAllowed == 1){
        $.ajax({
            type: "POST",
            data:{
                "function" : lastRequested["functionname"]
                ,"page" : ($("#id_currentpage")[0]  && loadType == "table" ? $("#id_currentpage")[0].value : 1)
                ,"quicksearch" : ($("#id_quicksearch")[0] && loadType == "table" ? $("#id_quicksearch")[0].value : "")
                ,"id" : lastRequested["id"]
            },
            url: "./php/datasetloader.php",
            success: function(response){
                let json = JSON.parse(response);
                if(json.success){

                    if(loadType != "table"){
                        if(json.values !== undefined){
                            if(json.values.length > 0){
                                if(globalPageLoaderJson.functionconfig.DoLoadAdditionalData == 1){
                                    DoLoadAdditionalData(true);
                                }
                            }
                        }
                    }
                    else{
                        if(globalPageLoaderJson.functionconfig.DoLoadAdditionalData == 1){
                            DoLoadAdditionalData(true);
                        }
                    }
                    
                    if(loadType == "table"){
                        totalRowsForQuery = json.totalRows;
                        loadDataToTable(json.values, globalPageLoaderJson.functionconfig.DoLoadAdditionalData == 0);
                    }
                    else{
                        if(json.values.length == 0){
                            destroyTotalForm();
                        }
                        else{
                            loadDataIntoForms(json.values);
                            startUpCheckValid(false);
                        }
                    }

                }
                else{
                    setAlertField("id_alert", json.msg, true, "");
                }                
            },
            failure:function(){
                setAlertField("id_alert", "Server Error", true, "");
            }
        });
    }
    else if(globalPageLoaderJson.functionconfig.DoLoadAdditionalData == 1){
        DoLoadAdditionalData(true);
        doRenderTableData();
    }

    if(loadType == "form" && globalPageLoaderJson.functionconfig.doSaveData == 1){
        startUpCheckValid();
    }    
}


function startUpCheckValid(){
    let amountfields = $("input").length + $("select").length + $("textarea").length;
    if(amountfields == 1){
        checkIfFormIsValid(false);
    }
}


function DoLoadAdditionalData(doRender){
    $.ajax({
        type: "POST",
        data:{
            "function" : lastRequested["functionname"]
            ,"type" : lastRequested["type"]
            ,"id" : lastRequested["id"]
        },
        url: "./php/datasetloader_additionalinfo.php",
        success: function(response){
            let json = JSON.parse(response);
            if(json.success){
                showAdditionalData(json.additionalValues);

                if(doRender){
                    doRenderTableData();
                }



            }
            else{
                setAlertField("id_alert", json.msg, true, "");
            }                
        },
        failure:function(){
            setAlertField("id_alert", "Server Error", true, "");
        }
    });
}

function loadDataIntoForms(values){
    for(var i=0; i<values.length;i++){
        let htmlobject = $("#" + values[i].name)[0];

        if(htmlobject !== undefined){

                
            let isDateField = checkIfFieldIsDatefield(htmlobject);

            if(isDateField){
                htmlobject.value = DateConvertDateBaseToFormsFormat(values[i].value); 
            }
            else{
                htmlobject.value = values[i].value;
            }


            let elements = document.getElementsByClassName('valueby_' + values[i].name);
            for(var k=0; k < elements.length;k++ ){
                elements[k].value = values[i].value;
                elements[k].innerHTML = getWord("extrabutton",elements[k].id+"_"+values[i].value);
            }
            
        }
    }
}

function loadDataToTable(data, doRender){
    $('#maintable').children('tbody').empty();
    let renderer = getColumnRenderer();
    for(var i = 0 ; i<data.length;i++){
        let rowcontent = "<tr>";
        for(var j =0; j < data[i].length;j++){
            let columnRenderer = "";
            if(renderer[data[i][j].id] !== undefined){
                columnRenderer = ' class="'+renderer[data[i][j].id]+'"';
            }
            rowcontent+="<td"+columnRenderer+">" + globalReplace(data[i][j].value) + "</td>";
        }
        rowcontent+="</tr>";


        $('#maintable').children('tbody').append(rowcontent);
    }

    if(doRender){
        doRenderTableData();
    }

    checkForPageChange();
}

function getReasonIfIsWanted(reasonvalue){
    let reason = reasonvalue.trim();
    let text ="";
    if(reason == ""){
        reason = getWord("manhunt","is_wanted_reason_unknown");
    }
    text += "<strong>" + getWord("manhunt","reason")+"</strong>" + " " + reason + "<br><br>";
    text += getWord("manhunt","is_wanted_additional_info");
    return text;
}


function destroyTotalForm(){
    DaBurnerGermany.setBody("");
    setAlertField("id_alert",'<h4>'+getWord("global","no_data_to_display")+'</h4>'+getWord("global","no_data_to_display_changepage")+'', true, "danger");
}