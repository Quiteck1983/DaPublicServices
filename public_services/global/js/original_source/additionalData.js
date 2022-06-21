function showAdditionalData(data){
    let string = ""
    string += "if(window.additionalData_"+lastRequested["functionname"]+" !== undefined){"
    string += "additionalData_"+lastRequested["functionname"]+"(data);"
    string += "}";
    eval(string);
}