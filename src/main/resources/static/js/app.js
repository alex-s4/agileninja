var regFormRole = document.querySelector("#regform-roles")


// This will change form when role was changed in registration page
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

