function Grid(properties){
    this.config = {
        id:""
        ,columns:[]
        ,tabledata:[]
        ,renderer:{}
        ,cls:["table"]
        ,clsTableHead:[]
        ,clsTableBody:[]
        ,needsCount:false
        ,allowQuicksearch:false  
        ,showHeader:true 
    };
    DaBurnerGermany.writePropertiesToObject(properties, this);
    this.clsTableSmall = "table-sm";
}

Grid.prototype.getFooter = function(){
    if(this.config.needsCount == true){

        return '<div id="id_label_entries"></div>' 
            + DaBurnerGermany.CompositeField({
                items:[
                    DaBurnerGermany.Button({
                        id:"id_previouspage"
                        ,text:getWord("global","navigate_back")
                        ,onclick:"changeDatapagePrevious()()"
                        ,cls:["btn-dark"]
                        ,width:1
                        ,disabled:false
                    }),
                    DaBurnerGermany.TextField({
                        id:"id_currentpage"
                        ,fieldLabel:""
                        ,cls:[]
                        ,hidden:false
                        ,onKeyup:""
                        ,allowBlank:true
                        ,readOnly:true
                        ,disabled:false
                        ,value:"1"
                        ,width:1
                    }),
                    DaBurnerGermany.Button({
                        id:"id_nextpage"
                        ,text:getWord("global","next")
                        ,onclick:"changeDatapageNext()()"
                        ,cls:["btn-dark"]
                        ,width:1
                        ,disabled:false
                    })
                ]
            });
    }    
    else{
        return "";
    }
}

Grid.prototype.getQuicksearch = function(){
    if(this.config.allowQuicksearch == true){
        return DaBurnerGermany.TextField({
            id:"id_quicksearch"
            ,fieldLabel:getWord("global","quicksearch")
            ,cls:[]
            ,hidden:false
            ,onKeyup:"startQuicksearch(event)"
            ,allowBlank:true
            ,readOnly:false
            ,disabled:false
            ,value:""
        });
    }
    else{
        return "";
    }
}

Grid.prototype.create = function(){
    if(DaBurnerGermany.getSmallView() == true){
        DaBurnerGermany.addClass(this.clsTableSmall, this);
    }

    let content = "";
    content+=this.getQuicksearch();
    content += '<table id = "'+this.config.id+'" class = "'+this.config.cls.join(' ')+'">';

    if(this.config.showHeader == true){
        content += '<thead'
        content += (this.config.clsTableHead.length > 0? ' class = "' + this.config.clsTableHead.join(' ') : "")
        content += '>';    
    
        content += '<tr>';
        for(var i=0 ; i < this.config.columns.length;i++){
            content += '<th id = "'+this.config.columns[i].id+'">' + this.config.columns[i].name + '</th>';
        }
        content += '</tr>';
        content += '</thead>';
    }
    
    content += '<tbody '
    content += (this.config.clsTableBody.length > 0? ' class = "' + this.config.clsTableBody.join(' ') : "") + '"'
    content += '>';


    for(var i=0 ; i < this.config.tabledata.length;i++){
        content += '<tr>';

        for(var j=0; j<this.config.tabledata[i].length;j++){
            let temp = this.config.tabledata[i][j];
            let renderer = "";
            let _class = "";

            if(this.config.renderer[temp.id] !== undefined){
                renderer = this.config.renderer[temp.id];   
            }
            if(renderer != ""){
                _class = ' class = "'+renderer+'"';
            }
            content += '<td'+_class+'>'+temp.value+"</td>";
        }
        content += '</tr>';
    }
    content += '</tbody>';
    content += "</table>";

    content += this.getFooter();

    return content;
}