function getWord(programmtype, keyword){
    let retval = keyword;
    let translationfound = false;
    if (Translations[programmtype] !== undefined) {
        if(Translations[programmtype][keyword] !== undefined){
            if(Translations[programmtype][keyword].replace(/ /g,"") !== ""){
                retval = Translations[programmtype][keyword];
                translationfound = true;
            }    
        }
        
    }
    if(!translationfound){
        console.log("Translations["+programmtype+"]["+keyword+"] is undefined");
    }
    return retval;
}


function setDateByInput(object){
    let rawvalue = object.value;
    let defaultValue = "__.__.____";

    rawvalue = rawvalue.replace(/[^0-9.]/g, '').replace(/\./g,"");
    let newValue = "";
    for(var i=0; i < rawvalue.length;i++){
        if(i==2 || i == 4){
            newValue+=".";
        }   
        newValue+=rawvalue[i];
    }
    object.value = newValue;

    checkIfFormIsValid(true);
}

function checkIfFieldIsDatefield(object){
    let retval = false;
    if(object.getAttribute("subtype") !== null && object.getAttribute("type")){
        let type = object.getAttribute("type");
        let subtype = object.getAttribute("subtype");
        if(type == "text" && subtype == "date"){
            retval = true;
        }
    }
    return retval;
}

function DateConvertToDataBaseFormat(datevalue){

    let year = datevalue.substring(6,10);
    let month = datevalue.substring(3,5);
    let day = datevalue.substring(0,2);

    if(year == ''|| year.length<4){
        year = '0000';
    }
    if(month == '' || month.length<2){
        month = '00';
    }

    if(day == '' || day.length<2){
        day = '00';
    }

    return year + "-" + month + "-" + day;
}
function DateConvertDateBaseToFormsFormat(datevalue){

    let temp = datevalue.split("-");

    let isValid = new Date().getTime() <= new Date(temp).getTime();


    let year = temp[0];
    let month = temp[1];
    let day = temp[2];

    return day + "." + month + "." + year;
}

function checkIfDateValid(datevalue){
    let date = DateConvertToDataBaseFormat(datevalue);
    var d = new Date(date);   
    var mindate = new Date(DaBurnerGermany.minDate);   
    var maxdate = new Date(DaBurnerGermany.maxDate);   

    return d.getTime() > 0 && d.getTime() >= mindate.getTime && d.getTime() <= maxdate.getTime();
}

function getFieldMaxLength(object){
    let retval = 0;
    let maxLengthAttr = object.getAttribute("dbgmaxlength");

    if(maxLengthAttr !== undefined){
        if(maxLengthAttr > 0){
            retval = maxLengthAttr;
        }
    }
    return retval;
}

function getFieldMinLength(object){
    let retval = 0;
    let minLengthAttr = object.getAttribute("dbgminlength");

    if(minLengthAttr !== undefined){
        if(minLengthAttr > 0){
            retval = minLengthAttr;
        }
    }
    return retval;
}

function checkIfFormIsValid(markInvalid){
    customFormHandler();
    var forms = document.getElementsByClassName('needs-validation');

    var valid = true;

    for(var i=0; i<forms.length; i++){
        if(forms[i].readOnly === false || forms[i].readOnly === undefined){
            let fieldLengthValid = true;
            let tempValid = true;

            maxLength = getFieldMaxLength(forms[i]);
            minLength = getFieldMinLength(forms[i]);

            
            let isDateField = checkIfFieldIsDatefield(forms[i]);


            
            if(isDateField){
                tempValid = checkIfDateValid(forms[i].value);
            }

            if(maxLength > 0 || minLength > 0){

                if(maxLength > 0){
                    if(forms[i].value.length > maxLength){
                        fieldLengthValid = false;
                    }
                }

                if(minLength > 0){
                    if(forms[i].value.length < minLength){
                        fieldLengthValid = false;
                    }
                }                
            }


            if(forms[i].value.replace(/ /g,"").replace(/\n/g,"")!="" && tempValid && fieldLengthValid){
                DaBurnerGermany.deleteClass(forms[i].id, "form-invalid");
            }
            else{
                valid=false;
                if(markInvalid){
                    DaBurnerGermany.doAddClass(forms[i].id, "form-invalid");
                }
            }
        }       
    }

    if($("#save")[0]){
        $("#save")[0].disabled = !valid;
    }
}

function customFormHandler(){
    if(DBG.getObj("id_perpetrator") !== undefined && DBG.getObj("id_perpetrator_description") !== undefined){
        let cbval = DBG.getObj("id_perpetrator")[0].value;
        if(cbval == 0){
            DaBurnerGermany.setAllowEmpty(false, "id_perpetrator_description");
        }
        else{
            DaBurnerGermany.setAllowEmpty(true, "id_perpetrator_description");
        }

        

    }

}

function checkIfPasswordFieldsValid(){
    let passfield = $("#id_new_password")[0];
    let passfield_confirm = $("#id_new_password_confirm")[0];

    let valid = false;
    let errorMessage = "";

    if(passfield.value == "" && passfield_confirm != ""){
        resetAlert();
        $("#savePassword")[0].disabled = true;
    }
    else{
        if(passwordRegex.test(passfield.value)){

            if(passfield_confirm.value === passfield.value){
                valid = true;
            }
            else{
                errorMessage = "<strong>" + getWord("password","passworts_not_match") + "</strong>";
            }
        }
        else{
            errorMessage = "<strong>" + getWord("password","password_policy_error") + "</strong><br>";
            errorMessage += getWord("global","min_length") +" "+ passwordConfig.min_length + "<br>";
            errorMessage += getWord("global","max_length") +" "+ passwordConfig.max_length + "<br>";
            if(passwordConfig.require_capital_letter){
                errorMessage += getWord("password","pwd_requires_capital_letter") + "<br>";
            }
            if(passwordConfig.require_digit){
                errorMessage += getWord("password","pwd_requires_digit") + "<br>";
            }
            if(passwordConfig.require_special_char){
                errorMessage += getWord("password","pwd_require_special_char");
            }
        }
        if(valid){
            resetAlert();
            $("#savePassword")[0].disabled = false;
        }
        else{            
            setAlertField("id_alert", errorMessage, true, "");

            $("#savePassword")[0].disabled = true;
        }
    }    
}

function createFieldArrayByConfig(formCfg){
    let fields = [];
    let index = -1;
    let lastGroup = -10;

    for(var i=0; i<formCfg.length; i++){
        if(lastGroup != formCfg[i].form_group){
            index++;
            lastGroup = formCfg[i].form_group;
        }

        if(fields[index] === undefined){
            fields[index] = [];
        }
        
        fields[index].push(formCfg[i]);
    }

    return fields;
}



function checkForPageChange(){
    if($("#id_currentpage")[0]){
        var previousDisabled = (1 * $("#id_currentpage")[0].value <= 1);
        var nextDisabled = (10 * $("#id_currentpage")[0].value >= totalRowsForQuery);
    
        $("#id_previouspage")[0].disabled = previousDisabled;
        $("#id_nextpage")[0].disabled = nextDisabled;    
    
        let text = getWord("global", "showentities");
        text = text.replace("@@from@@", (($("#id_currentpage")[0].value -1) * 10) + 1);
        let length = (($("#id_currentpage")[0].value -1) * 10 ) + $('#maintable').children('tbody').children().length
        text = text.replace("@@to@@", length );
        text = text.replace("@@totalcount@@", totalRowsForQuery );
        $("#id_label_entries")[0].innerHTML = text
    }

    
}

function startQuicksearch(event){
    if(event.keyCode === 13){
        $("#id_currentpage")[0].value = 1;    
        doLoadRequiredData();
    }
}

function changeDatapagePrevious(){
    $("#id_currentpage")[0].value =  (1*$("#id_currentpage")[0].value)-1;    
    doLoadRequiredData();
}

function changeDatapageNext(){
    $("#id_currentpage")[0].value =  (1*$("#id_currentpage")[0].value)+1;    
    doLoadRequiredData();
}








function getField(fieldCfg, currentValue, columnMD){
    let content = "";

    if(dropDownConfig[fieldCfg.columnname] !== undefined){
        let curval = (currentValue == "" ? "0" : currentValue);


        if(fieldCfg.form_type == "select-search"){
            return DaBurnerGermany.ComboBox({
                id:"id_"+fieldCfg.columnname
                ,fieldLabel:getWord("columns",fieldCfg.columnname)
                ,cls:[]
                ,hidden:fieldCfg.isHidden
                ,width:columnMD
                ,height:fieldCfg.height
                ,onchange:"checkIfFormIsValid(true)"
                ,allowBlank:(fieldCfg.needsValidation == 0)
                ,readOnly:fieldCfg.isReadOnly
                ,disabled:false
                ,value:curval
                ,data:dropDownConfig[fieldCfg.columnname]
                ,allowSearch:true
                ,StartBlank:true
                
            });
        }
        else{
            return DaBurnerGermany.ComboBox({
                id:"id_"+fieldCfg.columnname
                ,fieldLabel:getWord("columns",fieldCfg.columnname)
                ,cls:[]
                ,hidden:fieldCfg.isHidden
                ,width:columnMD
                ,height:fieldCfg.height
                ,onchange:"checkIfFormIsValid(true)"
                ,allowBlank:(fieldCfg.needsValidation == 0)
                ,readOnly:fieldCfg.isReadOnly
                ,disabled:false
                ,value:curval
                ,data:dropDownConfig[fieldCfg.columnname]
                
            });
        }      
    }
    else{
        if(fieldCfg.form_type.substring(0,6)  == "alert-"){
            let alerttype = fieldCfg.form_type.replace("alert-","");
            return getAlertBox(fieldCfg.columnname, alerttype);


        }
        else{

            if(fieldCfg.form_type == "text" || fieldCfg.form_type == "password" || fieldCfg.form_type == "select-search"){
                let type = fieldCfg.form_type;
                if(fieldCfg.form_type == "select-search"){
                    type = "text";
                }

                return DaBurnerGermany.TextField({
                    id:"id_"+fieldCfg.columnname
                    ,type:fieldCfg.form_type
                    ,fieldLabel:getWord("columns",fieldCfg.columnname)
                    ,cls:[]
                    ,hidden:fieldCfg.isHidden
                    ,width:columnMD
                    ,height:fieldCfg.height
                    ,onKeyup:"checkIfFormIsValid(true)"
                    ,allowBlank:(fieldCfg.needsValidation == 0)
                    ,readOnly:fieldCfg.isReadOnly
                    ,disabled:false
                    ,value:currentValue
                    ,minLength:fieldCfg.textMixLength
                    ,maxLength:fieldCfg.textMaxLength
                });
            }
            else if(fieldCfg.form_type == "textarea"){
                
                return DaBurnerGermany.TextArea({
                    id:"id_"+fieldCfg.columnname
                    ,fieldLabel:getWord("columns",fieldCfg.columnname)
                    ,cls:[]
                    ,hidden:fieldCfg.isHidden
                    ,width:columnMD
                    ,height:fieldCfg.height
                    ,onKeyup:"checkIfFormIsValid(true)"
                    ,allowBlank:(fieldCfg.needsValidation == 0)
                    ,readOnly:fieldCfg.isReadOnly
                    ,disabled:false
                    ,value:currentValue
                    
                });
            }

            else if(fieldCfg.form_type == "number"){
                return DaBurnerGermany.NumberField({
                    id:"id_"+fieldCfg.columnname
                    ,fieldLabel:getWord("columns",fieldCfg.columnname)
                    ,cls:[]
                    ,hidden:fieldCfg.isHidden
                    ,width:columnMD
                    ,height:fieldCfg.height
                    ,onKeyup:"checkIfFormIsValid(true)"
                    ,allowBlank:(fieldCfg.needsValidation == 0)
                    ,readOnly:fieldCfg.isReadOnly
                    ,disabled:false
                    ,value:currentValue
                    ,allowDecimals:false
                    
                });
            }

            else if(fieldCfg.form_type == "decimal"){
                return DaBurnerGermany.NumberField({
                    id:"id_"+fieldCfg.columnname
                    ,fieldLabel:getWord("columns",fieldCfg.columnname)
                    ,cls:[]
                    ,hidden:fieldCfg.isHidden
                    ,width:columnMD
                    ,height:fieldCfg.height
                    ,onKeyup:"checkIfFormIsValid(true)"
                    ,allowBlank:(fieldCfg.needsValidation == 0)
                    ,readOnly:fieldCfg.isReadOnly
                    ,disabled:false
                    ,value:currentValue
                    ,allowDecimals:true
                    
                });
            }
            else if(fieldCfg.form_type == "date"){
                return DaBurnerGermany.DateField({
                    id:"id_"+fieldCfg.columnname
                    ,fieldLabel:getWord("columns",fieldCfg.columnname)
                    ,cls:[]
                    ,hidden:fieldCfg.isHidden
                    ,width:columnMD
                    ,height:fieldCfg.height
                    ,onKeyup:"setDateByInput(this)"
                    ,onselect:"checkIfFormIsValid(true)"
                    ,allowBlank:(fieldCfg.needsValidation == 0)
                    ,readOnly:fieldCfg.isReadOnly
                    ,disabled:false
                    ,value:currentValue
                    
                });
                
            }
        }        
    }


    
    return content;
}



function changePage(url_addon, clickedID){
    let id = "";

    if(url_addon == "save_participant"){
        url_addon = "view_participants";
    }
    

    if(url_addon!=""){
        if(url_addon.substring(0,3) != "?i="){
            url_addon = "?i=" + url_addon;
        }
    }


    if(clickedID != -1){
        id = (url_addon==""?"?":"&") + "id=" + clickedID;
    }

    window.location.href = serveraddress + url_addon + id;
}

function getObjectValues(returnJson){
    let inputs = $("input");
    let selects = $("select");
    let textareas = $("textarea");
    let data = {};

    for(var i = 0; i < inputs.length; i++){
        let isDateField = checkIfFieldIsDatefield(inputs[i]);
        let val = inputs[i].value;
        if(isDateField){
            val = DateConvertToDataBaseFormat(val);
        }

        let id = inputs[i].id.replace("id_","");
        
        data[id] = val;     
    }
    for(var i = 0; i < selects.length; i++){
        let id = selects[i].id.replace("id_","");
        let val = selects[i].value;
        data[id] = val;     
    }
    for(var i = 0; i < textareas.length; i++){
        let id = textareas[i].id.replace("id_","");
        let val = textareas[i].value.replace(/\n/g,"<br>");
        data[id] = val;     
    }

    if(returnJson){
        return JSON.stringify(data);
    }
    else{
        return data;
    }

    
}


function saveData(buttonType){

    let btnCfg = getBtnPageCfg(globalPageLoaderJson.function_buttons[buttonType]);

    $.ajax({
        type: "POST",
        data:{
            "function" : lastRequested["functionname"]
            ,"data" : getObjectValues(true)
            ,"id" : lastRequested["id"]
            ,"type" :lastRequested["type"]
        },

        url: "./php/datasetsaver.php",
        success: function(response){
            let json = JSON.parse(response);

            if(json.success){            

                if(lastRequested["functionname"] == "form_usersettings"){
                    window.location.reload();
                }
                else{
                    doLoadPageContent(btnCfg["destination"],btnCfg["loadType"],btnCfg["id2load"]);
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








function showDeleteConfirm(id, optmysqltable){
    let btns = '<div class="form-row">';

    btns+='<div class="form-group col-md-6">';

    

    btns+='<button class="btn btn-block btn-primary" onclick="resetAlert()">'+getWord("global","cancel")+'</button>';
    btns+='</div>';

        
    btns+='<div class="form-group col-md-6">';
    btns+='<button class="btn btn-block btn-danger" id="save" onclick="deleteData('+id+',\''+optmysqltable+'\')">'+getWord("global","delete")+'</button>';
    btns+='</div>';
    btns += "</div>";
    

    $("#id_alert")[0].innerHTML = "Sind Sie sich sicher?<br>Die Daten werden entgültig gelöscht!"+btns;
    $("#id_alert")[0].style.display = "block";
    $("#id_alert")[0].style.textAlign = "center";
}

function resetAlert(){
    setAlertField("id_alert", "", false, "warning");
    setAlertField("id_alertinfo", "", false, "primary");
}

function reloadData(){
    resetAlert()
    doLoadRequiredData();
}

function deleteData(id, optmysqltable){
    if(optmysqltable === undefined){
        optmysqltable = "";
    }

    $.ajax({
        type: "POST",
        data:{
            "function" : lastRequested["functionname"]
            ,"optTable" : optmysqltable
            ,"id" : id
        },
        url: "./php/datadeleter.php",
        success: function(response){
            let json = JSON.parse(response);

            if(json.success){
                reloadData();
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

function getAllowedByFunctionName(function_name){
    let rightdefinition = FunctionToRights[function_name];
    let allowed = true;

    if(rightdefinition !== undefined){
        allowed = checkAllowed(rightdefinition.right_function_name, rightdefinition.right_sub_function);
    }

    return allowed;
    
}

function checkAllowed(programmtype, subaction){
    let allowed = true;

    if(programmtype != ""){
        if(UserRights[programmtype] !== undefined){
            if(UserRights[programmtype][subaction] !== undefined){
                allowed = UserRights[programmtype][subaction];
            }
            else{
                console.log("userights["+programmtype+"]["+subaction+"] is undefined!");
            }
        }
        else{
            console.log("userights["+programmtype+"] is undefined!");
        }
    }

    
    return allowed;
}

function toggleButton(element){

    let btn_no = element.children[0];
    let btn_yes = element.children[1];


    if(btn_yes.classList.contains("active") !== false){
        btn_yes.classList.remove("active");
        btn_yes.classList.replace("btn-success","btn-default");

        if(btn_no.classList.contains("active") === false){
            btn_no.classList.add("active");
            btn_no.classList.replace("btn-default","btn-danger");
        }
        
        element.classList.replace("ThisRowIsSelected","ThisRowIsNotSelected");
    }
    else{
        btn_no.classList.remove("active");
        btn_no.classList.replace("btn-danger","btn-default");

        if(btn_yes.classList.contains("active") === false){
            btn_yes.classList.add("active");
            btn_yes.classList.replace("btn-default","btn-success");
        }
        element.classList.replace("ThisRowIsNotSelected","ThisRowIsSelected");
    }
}


function getSelectedRights(){
    let retval = [];

    $(".ThisRowIsSelected").each(function(){
        let id = $(this).parent().parent().find("td")[0].innerHTML;
        retval.push(id);
    });

    return retval;
}






function setAlertField(alertid, htmlcontent, display, colortype){
    let alerttypes = [
        "alert-primary"
        ,"alert-secondary"
        ,"alert-success"
        ,"alert-danger"
        ,"alert-warning"
        ,"alert-info"
        ,"alert-light"
        ,"alert-dark"
    ];

    DBG.update(alertid, htmlcontent);
    DBG.setVisible(alertid, display);
    if(colortype != ""){
        for(var i=0;i <alerttypes.length;i++){
            DBG.deleteClass(alertid, alerttypes[i]);    
        }
    }
    DBG.doAddClass(alertid, "alert-"+colortype);
}


function convertTableHeader(headers){
    let Cols = [];
    for(var i=0; i < headers.length; i++){
        Cols.push({
            "id":headers[i]
            ,"name":getWord("columns",headers[i])
        }); 
    }

    return Cols;
}


function globalReplace(input){

    let replaceFrom=[
        '@@CHARPARAPRAPH@@'
        ,'@@REPLACECHARPARAPRAPH@@'
        ,'@@REPLACEOWNER@@'
        ,'@@REPLACEPLATE@@'
        ,'@@REPLACEVEHICLE@@'
        ,'@@REPLACEVEHICLETYPE@@'
        ,'@@REPLACEOTHERS@@'
        ,'@@REPLACEREASON@@'
    ];
    let replaceTo = [
        '§'
        ,'§'
        ,getWord("registered_vehicle","owner")
        ,getWord("registered_vehicle","plate")
        ,getWord("registered_vehicle","vehicle")
        ,getWord("registered_vehicle","vehicle_type")
        ,getWord("global","others")
        ,getWord("manhunt","reason")
    ];


    for(var i=0; i<replaceFrom.length;i++){
        for(var j=0; j < input.split(replaceFrom[i]).length-1;j++){    
            input = input.toString().replace(replaceFrom[i],replaceTo[i]);
        }
    }
    return input;
}