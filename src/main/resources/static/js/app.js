var regFormRole = document.querySelector("#regform-roles")

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