function FieldSet(properties){
    this.config = {
        id:""
        ,title:""
        ,startCollapsed:false
        ,collapsible:true
        ,colorscheme:"dark"
        ,items:[]
    };
    DaBurnerGermany.writePropertiesToObject(properties, this);
}

FieldSet.prototype.create = function(){
    content = DaBurnerGermany.Button({
        id:""
        ,text:this.config.title
        ,dataToggle:"collapse"
        ,dataTarget:"#"+this.config.id
        ,areaExpanded:"false"
        ,areaControls:this.config.id
        ,onclick:""
        ,cls:[
            "btn-" + this.config.colorscheme
            ,"btn-block"
            ,"text-left"
        ]
        ,width:0
        ,disabled:(this.config.collapsible == true ? false : true)
    });

    content+='<div class="'+(this.config.startCollapsed == true? "collapse":"show")+'" id="'+this.config.id+'">';
    content+='<div class="card card-body bg-'+this.config.colorscheme+' card-shadow">';

    for(var i=0; i<this.config.items.length; i++){
        content+=this.config.items[i];
    }
    content+='</div>';
    content+='</div>';

    return content;
}