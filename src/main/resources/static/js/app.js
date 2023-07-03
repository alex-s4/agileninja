var regFormRole = document.querySelector("#regform-roles")


// This will change form when role was changed in registration page
if(window.location.href=="http://localhost:8080/registration")
{
    if(regFormRole.value=="user"){
        console.log()
        document.querySelector("#admin-regForm").style.display = "none";
        document.querySelector("#user-regForm").style.display = "block";
    } else if (regFormRole.value=="admin"){
        document.querySelector("#user-regForm").style.display = "none";
        document.querySelector("#admin-regForm").style.display = "block";
    }
    
    regFormRole.addEventListener("change", function(){
        console.log(regFormRole.value)
        if(regFormRole.value=="user"){
            console.log()
            document.querySelector("#admin-regForm").style.display = "none";
            document.querySelector("#user-regForm").style.display = "block";
        } else if (regFormRole.value=="admin"){
            document.querySelector("#user-regForm").style.display = "none";
            document.querySelector("#admin-regForm").style.display = "block";
        }
    })

}


// New Project Form will display on click
function openFormNewProj(){
    document.getElementById("new-proj-form").style.display = "block"
}

function closeFormNewProj(){
    document.getElementById("new-proj-form").style.display = "none"
}

// New Ticket Form will display on click
function openFormNewTkt(){
    document.getElementById("new-tkt-form").style.display = "block"
}

function closeFormNewTkt(){
    document.getElementById("new-tkt-form").style.display = "none"
}




$('#btn-submit-filter').click(function () {

    // Get values from Project ("proj") Filter
    var checkedProj = $('input[type="checkbox"].form-check-input-proj:checked'); // get checked values
    var checkedValuesProj = [];
    checkedProj.each(function (i) {
        checkedValuesProj.push(checkedProj[i].value); // add checked values to our temporary list
    });
    
    
    // Get values from Type ("type") Filter
    var checkedType = $('input[type="checkbox"].form-check-input-type:checked'); // get checked values
    var checkedValuesType = [];
    checkedType.each(function (i) {
        checkedValuesType.push(checkedType[i].value); // add checked values to our temporary list
    });


    // Get values from Status ("status") Filter
    // Get values from Priority ("prio") Filter
    // Get values from Severity ("severity") Filter
    // Get values from Assignee ("assignee") Filter
    
    
    
    
    var queryParam = 'proj=' + checkedValuesProj.join(',') + '&type=' + checkedValuesType.join(','); // create query param

    //$('.output').html('Query param is: "' + queryParam + '"'); // verify output

   

    window.location.href="http://localhost:8080/?"+queryParam;

    console.log(checkedValuesType.join(','))
});


