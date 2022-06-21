var globalPageLoaderJson = [];
var lastRequested = [];
var PageLoadInProgress = false;

function doLoadPageContent(functionname, type, lastclickid){

    if(PageLoadInProgress){
        return false;
    }

    PageLoadInProgress=true;
    resetAlert();

    if(type == ""){
        type = "table";
    }
    lastRequested["functionname"] = functionname;
    lastRequested["type"] = type;
    lastRequested["id"] = lastclickid;

    $("#pagertitle").fadeOut("fast");
    $("#id_content").fadeOut("fast",function(){
        showLoadingBar();   
    });

    setTimeout(function() {
        $.ajax({
            type: "POST",
            data:{
                "function" : functionname
                ,"type" : type
            },
            url: "./php/pageLoader.php",
            success: function(response){
                let json = JSON.parse(response);
                if(json.success){
                    dropDownConfig = json.dropdownConfig;

                    
                    DaBurnerGermany.setTitle(getWord("pageloader",json.pageTitle));

                    globalPageLoaderJson = json;
                    createPageContent(json);
                    
                }
                else{
                    setAlertField("id_alert", json.msg, true, "");
                    hideLoadingBar();
                }                
            },
            failure:function(){
                setAlertField("id_alert", "Server Error", true, "");
                hideLoadingBar();
            }
        }); 
    }, 500);
}

function createPageContent(json){
    
    DaBurnerGermany.setBody("");
    let showError = false;

    if(json.functionconfig.length == 0){
        showError = true;
    }
    else{
        DaBurnerGermany.setSmallView(json.functionconfig.UseSmallView);
        DaBurnerGermany.setPageType(json.functionconfig.type);

        if(json.functionconfig.type == 'form' && json.formconfig.length > 0 ){     
            handleAddButton(json.function_buttons.addButton);
            getFormButtonsTop(json.function_buttons.backButton, json.function_buttons.editButton);
            getFieldsByArray(json.formconfig);
            getFormButtonsBottom(json.function_buttons.CancelSaveButton, json.functionconfig.doSaveData);
            getExtraButtonsBottom(json.extraButtons);

            DaBurnerGermany.create();


            doLoadRequiredData();           

        }
        else if(json.functionconfig.type == 'table' && json.tableconfig.length > 0){
            

            handleAddButton(json.function_buttons.addButton);
            getTableButtonsTop(json.function_buttons.backButton);


            let Columns = [];
            for(var i=0; i < json.tableconfig.length; i++){
                Columns.push({
                    "id":json.tableconfig[i]["columnname"]
                    ,"name":getWord("columns",json.tableconfig[i]["columnname"])
                }); 
            }

            DaBurnerGermany.addElement(
                DaBurnerGermany.Grid({
                    id:"maintable"
                    ,columns:Columns
                    ,tabledata:[]
                    ,renderer:[]
                    ,cls:["table-dark"]
                    ,clsTableHead:[]
                    ,clsTableBody:["tbody-white"]
                    ,needsCount:json.functionconfig.needsCount
                    ,allowQuicksearch:json.functionconfig.allowQuicksearch
                })
            );

            getExtraButtonsBottom(json.extraButtons);
            DaBurnerGermany.create();
            doLoadRequiredData();
        }
        else if(json.functionconfig.type == 'custom'){

            if(json.functionconfig.DoLoadAdditionalData == 1){
                    DoLoadAdditionalData(true);    
            }
            else{
                showAdditionalData([]);
            }
        }
        else{
            showError = true;
        }
    }

    if(showError){
        DaBurnerGermany.setTitle("Error");
        content = "This page is not configured.";
        DaBurnerGermany.setBody(content);
    }
    hideLoadingBar();
}

function showLoadingBar(){
    DBG.doAddClass("loadingbar","loadingbar-middle");
    $("#loadingbar").html(
        '<div class="spinner-border spinner-big" role="status">'
        + '<span class="sr-only">Loading...</span>'
        + '</div>'
    );
}
function hideLoadingBar(){
    $("#loadingbar").html("");
    DBG.deleteClass("loadingbar","loadingbar-middle");
    $("#pagertitle").fadeIn("fast");
    $("#id_content").fadeIn("fast",function(){
        PageLoadInProgress=false;
    });
    
}