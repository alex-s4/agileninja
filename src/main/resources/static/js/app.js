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
    var checked = $('input[type="checkbox"].form-check-input:checked'); // get checked values
    var checkedValues = [];
    checked.each(function (i) {
        checkedValues.push(checked[i].value); // add checked values to our temporary list
    });
    var queryParam = 'proj=' + checkedValues.join(','); // create query param

    //$('.output').html('Query param is: "' + queryParam + '"'); // verify output

    console.log(queryParam)

    window.location.href="http://localhost:8080/?"+queryParam;
});


// document.querySelector("#btn-submit-filter").addEventListener("click", ()=>{
//     console.log("x")
// })
