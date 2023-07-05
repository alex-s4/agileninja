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

$('input[type="checkbox"].form-check-input-assignee').each(function(){
    $(this).prop('checked',localStorage.getItem(this.Id)=='true');
})


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
    var checkedStatus = $('input[type="checkbox"].form-check-input-status:checked'); // get checked values
    var checkedValuesStatus = [];
    checkedStatus.each(function (i) {
        checkedValuesStatus.push(checkedStatus[i].value); // add checked values to our temporary list
    });


    // Get values from Priority ("prio") Filter
    var checkedPriority = $('input[type="checkbox"].form-check-input-priority:checked'); // get checked values
    var checkedValuesPriority = [];
    checkedPriority.each(function (i) {
        checkedValuesPriority.push(checkedPriority[i].value); // add checked values to our temporary list
    });


    // Get values from Severity ("severity") Filter
    var checkedSeverity = $('input[type="checkbox"].form-check-input-severity:checked'); // get checked values
    var checkedValuesSeverity = [];
    checkedSeverity.each(function (i) {
        checkedValuesSeverity.push(checkedSeverity[i].value); // add checked values to our temporary list
    });

    // Get values from Assignee ("assignee") Filter
    var checkedAssignee = $('input[type="checkbox"].form-check-input-assignee:checked'); // get checked values
    var checkedValuesAssignee = [];
    checkedAssignee.each(function (i) {
        checkedValuesAssignee.push(checkedAssignee[i].value); // add checked values to our temporary list
    });
    
    
    console.log(checkedValuesAssignee.join(','))
    
    // CREATES A QUERY PARAMETER
    // IMPORTANT: As much as possible, do not rename your request parameter as same as member variable of an object to avoid type error 
    var queryParam = 'proj=' + checkedValuesProj.join(',') + '&type=' + checkedValuesType.join(',') 
                    + '&status=' + checkedValuesStatus.join(',') + '&prio=' + checkedValuesPriority.join(',')
                    + '&severity=' + checkedValuesSeverity.join(',') + '&assigned=' + checkedValuesAssignee.join(','); // create query param

    
    window.location.href="http://localhost:8080/?"+queryParam;
});



