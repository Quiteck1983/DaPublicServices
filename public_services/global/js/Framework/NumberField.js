
function NumberField(properties){
    this.config = {
        id:""
        ,type:""
        ,subtype:""
        ,cls:["form-control"]
        ,fieldLabel:""
        ,width:0
        ,height:0
        ,value:""
        ,hidden:false
        ,disabled:false
        ,readOnly:false
        ,isSmall:false
        ,allowBlank:true
        ,onselect:""
        ,onKeyup:""
        ,onchange:""
        ,data:""
        ,allowDecimals:false
        ,allowNegative:false
    };
    
    DaBurnerGermany.writePropertiesToObject(properties, this);
    this.smallClass = "form-control-sm";
    this.fieldType = "number";

    if(this.config.value === ""){
        this.config.value = 0;
    }
}

NumberField.prototype.create = function(){
    if(DaBurnerGermany.getSmallView() == true){
        DaBurnerGermany.addClass(this.smallClass, this)
    }
    if(this.config.allowBlank == false){
        DaBurnerGermany.setAllowBlank(this.config.allowBlank, this);
    }

    let disabledKeys = ["+"];

    if(this.config.allowDecimals == false){
        disabledKeys.push(".", ",");
    }
    if(this.config.allowNegative == false){
        disabledKeys.push("-");
    }

    let onkeydownkeyCodes = "";
    for(var i=0; i < disabledKeys.length;i++){
        onkeydownkeyCodes += (onkeydownkeyCodes == "" ? "" : " || " ) + "event.key==='"+disabledKeys[i]+"'";
    }


    return new FormGroup({
        width:this.config.width
        ,hidden:this.config.hidden
        ,items:[
            new FieldLabel({
                id:this.config.id
                ,label:this.config.fieldLabel
            }).create()
            ,'<input '
                + (this.config.id != "" ? 'id="' + this.config.id + '"':"")
                + ' type="'+this.fieldType + '"'
                + ' class="'+this.config.cls.join(" ") + '"'
                + ' value="'+this.config.value + '"'

                + (this.config.allowNegative == false ? ' min = "0"' : "")
                + (this.config.allowDecimals == true ? ' lang="en" step="any"' : ' step="1"')


                + (this.config.onKeyup !== '' ? ' onkeyup = "'+this.config.onKeyup + '"' : '')
                + (this.config.onselect !== '' ? ' onselect = "'+this.config.onselect + '"' : '')
                + ' onpaste="return false"'
                + ' onkeydown="if('+onkeydownkeyCodes+'){event.preventDefault();}"'
                + (this.config.disabled == true ? " disabled" : "")
                + (this.config.readOnly == true ? " readonly" : "")
                
                + '>'

        ]
    }).create();
}