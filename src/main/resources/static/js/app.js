$(".reg-btn").click(()=>{
    window.location.href = window.location.protocol + "//" + window.location.host + "/registration"
})


$('input[type="checkbox"], #btn-clear-filter').click(function () {
        
    // Get values from Project ("proj") Filter
    // get checked values
    var checkedProj = $('input[type="checkbox"].form-check-input-proj:checked');
    var checkedValuesProj = []
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
    
    
    // console.log(checkedValuesAssignee.join(','))

    // PROJ FILTER COUNT
    if(checkedValuesProj==0){
        $(".filter-count-proj").html("")
    }
    if(checkedValuesProj!=0){
        console.log(checkedValuesProj.length)
        $(".filter-count-proj").html(checkedValuesProj.length)
    }

    // TYPE FILTER COUNT
    if(checkedValuesType==0){
        $(".filter-count-type").html("")
    }
    if(checkedValuesType!=0){
        console.log(checkedValuesProj.length)
        $(".filter-count-type").html(checkedValuesType.length)
    }

    // STATUS FILTER COUNT
    if(checkedValuesStatus==0){
        $(".filter-count-stat").html("")
    }
    if(checkedValuesStatus!=0){
        console.log(checkedValuesStatus.length)
        $(".filter-count-stat").html(checkedValuesStatus.length)
    }

    // PRIORITY FILTER COUNT
    if(checkedValuesPriority==0){
        $(".filter-count-prio").html("")
    }
    if(checkedValuesPriority!=0){
        console.log(checkedValuesPriority.length)
        $(".filter-count-prio").html(checkedValuesPriority.length)
    }

    // SEVERITY FILTER COUNT
    if(checkedValuesSeverity==0){
        $(".filter-count-sev").html("")
    }
    if(checkedValuesSeverity!=0){
        console.log(checkedValuesSeverity.length)
        $(".filter-count-sev").html(checkedValuesSeverity.length)
    }

    // ASSIGNEE FILTER COUNT
    if(checkedValuesAssignee==0){
        $(".filter-count-ass").html("")
    }
    if(checkedValuesAssignee!=0){
        console.log(checkedValuesAssignee.length)
        $(".filter-count-ass").html(checkedValuesAssignee.length)
    }

    // CREATES A QUERY PARAMETER
    // IMPORTANT: As much as possible, do not rename your request parameter as same as member variable of an object to avoid type error 
    var queryParam = '?proj=' + checkedValuesProj.join(',') + '&type=' + checkedValuesType.join(',') 
                    + '&status=' + checkedValuesStatus.join(',') + '&prio=' + checkedValuesPriority.join(',')
                    + '&severity=' + checkedValuesSeverity.join(',') + '&assigned=' + checkedValuesAssignee.join(','); // create query param

    
    //window.location.href="http://localhost:8080/?"+queryParam;

    var currentURL = window.location.protocol + "//" + window.location.host + window.location.pathname + queryParam;
    window.history.replaceState({path:currentURL},'',currentURL)
    



    $("#btn-clear-filter").click(function(){
        queryParam="?proj=&type=&status=&prio=&severity=&assigned="
        currentURL = window.location.protocol + "//" + window.location.host + window.location.pathname + queryParam;
        window.location.href=currentURL
        $('input[type="checkbox"]').prop('checked', false)
    })
    
});

$("#btn-submit-filter").click(function(){
    window.location.href = document.URL;
}
)

// $("#btn-clear-filter").click(()=>{
//     console.log($('input[type="checkbox"]'))

//     $('input[type="checkbox"]').prop('checked', false)
//     trackFilter()
// })


// Persist checkbox checked state after page reload
var checkboxValues = JSON.parse(localStorage.getItem('checkboxValues')) || {};
var $checkboxes = $(".filter-checkbox-cont :checkbox");

var dropdownValues = JSON.parse(localStorage.getItem('checkboxValues')) || {};
var dropdowns = $(".input-group.dropdown-menu");

$checkboxes.on("change", function(){
    $checkboxes.each(function(){
      checkboxValues[this.id] = this.checked;
      
    });
    localStorage.setItem("checkboxValues", JSON.stringify(checkboxValues));
  });

  $.each(checkboxValues, function(key, value) {
    $("#" + key).prop('checked', value);
  });



// Ticket Page: Auto-update when select dropdown is changed or text fields loses focus
  $('.issuePropDropdown').change(function(){
    $('form#issuePropForm').submit()
    console.log(this[0].getAttribute("value"))
    console.log("test")
  })

  $('.issuePropInputText').blur(function(){
    $('form#issuePropForm').submit()
  })
  $('.issuePropInputText').on("input", function(e){
    var target = e.target

    // Count the current number of chars in Ticket Name field
    var tktNameCurrentLength = target.value.length;

    console.log(tktNameCurrentLength)
})













// Edit button will appear on hover of comment container
var commentContainer = $('.comment-cont-lc')
var cancelEditCmntBtn = $(".canc-btn")

// TO DO: INCLUDE DELETE BUTTON ON HOVER
commentContainer.mouseenter(function(e){
    $(this).css("background-color", "#e9e9e9")
    var editCommentBtn = $(".edit-comment-btn")

    $(this).find(".edit-comment-btn").css("display", "initial")
    
    })

commentContainer.mouseleave(function(e){
    $(this).css("background-color", "initial")
    var editCommentBtn = $(".edit-comment-btn")
    $(this).find(".edit-comment-btn").css("display", "none")
    
})


// Edit Comment form will appear upon hover of comment container
$(".edit-comment-btn").click(function(){
    var editCommentForm = $(this).closest("div").next().next()
    var charLengthCommentInput = editCommentForm.find("textarea").html().length * 2

    editCommentForm.css("display", "block")
    $(this).closest("div").next().css("display", "none")

    editCommentForm.find("textarea").focus()
    editCommentForm.find("textarea")[0].setSelectionRange(charLengthCommentInput,charLengthCommentInput)
    
    
})

// Form will be replaced back by the comment text display upon click of "cancel" button
cancelEditCmntBtn.click(function(){
    $(this).closest(".edit-comment-form").css("display", "none")
    var commentContent = $(this).parent().prev()
    
    commentContent.css("display", "initial")
    
    // console.log($(this).parent().prev().html())
    
    
})

console.log($("#regform-roles").val())

$("#regform-roles").change(()=>{
    console.log($("#regform-roles").val())
    console.log($("#regform-roles").attr("action"))
})






// This will change form when role was changed in registration page
// if(window.location.href=="http://localhost:8080/registration")
// {
//     if(regFormRole.value=="user"){
//         console.log()
//         document.querySelector("#admin-regForm").style.display = "none";
//         document.querySelector("#user-regForm").style.display = "block";
//     } else if (regFormRole.value=="admin"){
//         document.querySelector("#user-regForm").style.display = "none";
//         document.querySelector("#admin-regForm").style.display = "block";
//     }
    
//     regFormRole.addEventListener("change", function(){
//         console.log(regFormRole.value)
//         if(regFormRole.value=="user"){
//             console.log()
//             document.querySelector("#admin-regForm").style.display = "none";
//             document.querySelector("#user-regForm").style.display = "block";
//         } else if (regFormRole.value=="admin"){
//             document.querySelector("#user-regForm").style.display = "none";
//             document.querySelector("#admin-regForm").style.display = "block";
//         }
//     })
// }