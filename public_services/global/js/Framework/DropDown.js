function DropDown(properties){
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
        ,allowSearch:false
        ,StartBlank:false
    };

    DaBurnerGermany.writePropertiesToObject(properties, this);

    
    if(this.config.value == ""){
        this.config.value = 0;
    }

    this.smallClass = ["form-control-sm", "select-sm"];
    this.readOnlyClass = "select-readonly";
}

DropDown.prototype.setReadOnly = function(){
    if(this.config.readOnly == true){
        DaBurnerGermany.addClass(this.readOnlyClass, this);
    }   
}

DropDown.prototype.getOptions = function(){
    let content = "";
    for(var i = 0; i<this.config.data.length;i++){
        content+='<option value = "' + this.config.data[i].id  +'" '+(this.config.value == this.config.data[i].id ? "selected":"")+'>'+ this.config.data[i].name +'</option>';
    }
    return content;
}



DropDown.prototype.create = function(){

    this.setReadOnly();

    if(DaBurnerGermany.getSmallView() == true){
        for(var i = 0; i < this.smallClass.length;i++){
            DaBurnerGermany.addClass(this.smallClass[i], this);
        }
    }
    if(this.config.allowBlank == false){
        DaBurnerGermany.setAllowBlank(this.config.allowBlank, this);
    }

    let SearchField = "";

    if(this.config.allowSearch == true){
        let SearchFieldCls = ["form-control"];

        
        if(DaBurnerGermany.getSmallView() == true){
            SearchFieldCls.push("form-control-sm");
        }


        SearchField = '<input '
                + (this.config.id != "" ? 'id="search_' + this.config.id + '"':"")
                + ' type="text"'
                + ' class="'+SearchFieldCls.join(" ") + '"'
                + ' value=""'
                + ' onkeyup = "DaBurnerGermany.searchDropDown(this,\'' + this.config.id + '\',\''+this.config.onchange+'\')"'
                + (this.config.disabled == true ? " disabled" : "")
                + (this.config.readOnly == true ? " readonly" : "")
                + '>';
    }


    return new FormGroup({
        width:this.config.width
        ,hidden:this.config.hidden
        ,items:[
            new FieldLabel({
                id:this.config.id
                ,label:this.config.fieldLabel
            }).create()
            ,SearchField
            ,'<select '
                + (this.config.id != "" ? ' id="' + this.config.id + '"':"")
                + ' class="'+this.config.cls.join(" ") + '"'
                + (this.config.allowSearch == true ? 'onchange = "DaBurnerGermany.SearchableDropDownChange(this,\''+this.config.onchange+'\')"' : (this.config.onchange !== '' ? ' onchange = "'+this.config.onchange + '"' : ''))
                + (this.config.disabled == true ? " disabled" : "")
                +'>'
                +this.getOptions()
            +'</select>'
        ]
    }).create();
}