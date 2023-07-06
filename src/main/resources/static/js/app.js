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


$('input[type="checkbox"]').click(function () {
    
    // Get values from Project ("proj") Filter
    // get checked values
    var checkedProj = $('input[type="checkbox"].form-check-input-proj:checked');
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
    
    
    // console.log(checkedValuesAssignee.join(','))
    
    // CREATES A QUERY PARAMETER
    // IMPORTANT: As much as possible, do not rename your request parameter as same as member variable of an object to avoid type error 
    var queryParam = 'proj=' + checkedValuesProj.join(',') + '&type=' + checkedValuesType.join(',') 
                    + '&status=' + checkedValuesStatus.join(',') + '&prio=' + checkedValuesPriority.join(',')
                    + '&severity=' + checkedValuesSeverity.join(',') + '&assigned=' + checkedValuesAssignee.join(','); // create query param

    
    window.location.href="http://localhost:8080/?"+queryParam;
});


// Persist checkbox checked state after page reload
var checkboxValues = JSON.parse(localStorage.getItem('checkboxValues')) || {};
var $checkboxes = $(".filter-checkbox-cont :checkbox");

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
    console.log("test")
    $('form#issuePropForm').submit()
  })

  $('.issuePropInputText').blur(function(){
    console.log("test")
    $('form#issuePropForm').submit()
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

    editCommentForm.find("textarea").focus()
    editCommentForm.find("textarea")[0].setSelectionRange(charLengthCommentInput,charLengthCommentInput)
    
    
})

// Form will be replaced back by the comment text display upon click of "cancel" button
cancelEditCmntBtn.click(function(){
    $(this).closest(".edit-comment-form").css("display", "none")
})