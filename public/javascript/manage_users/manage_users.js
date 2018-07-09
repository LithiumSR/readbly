function manageUsersLoad(){
    let change_buttons = document.getElementsByClassName("change");
    let select = document.getElementsByClassName("select");
    let option = document.createElement("option");
    option.text = "-";
    for(var x=0; x < select.length; x++)
    {
        change_buttons[x].disabled = true;
        let tmp = select[x].options[0];
        select[x].options[select[x].options.length] = new Option('-', '-');
        select[x].options[0] = select[x].options[select[x].options.length-1];
        select[x].options[select[x].options.length] = tmp;
        select[x].selectedIndex = 0;
        select[x].addEventListener("change", function() {
            let select = document.getElementsByClassName("select");
            let change_buttons = document.getElementsByClassName("change");
            let x;
            for(x=0; x < select.length; x++) if(select[x]==this) break;
            if (this.value == "-") change_buttons[x].disabled = true;
            else change_buttons[x].disabled=false;
        });
    }
}
