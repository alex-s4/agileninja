$(".reg-btn").click(()=>{
    window.location.href = window.location.protocol + "//" + window.location.host + "/registration"
})


$('input[type="checkbox"], #btn-clear-filter, .btn-lc-sorter').click(function (e) {
        
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

    var columnToSort = ""; 

    // SORT TABLE COLUMN
    // switch (e.target.id)
    // {
    //     case "sort-key":
    //         columnToSort = "ticketKey"
    //         window.history.replaceState({path:currentURL},'',currentURL)
    //         console.log(document.URL)
    //         break;
    //     case "sort-type":
    //         columnToSort = "ticketType"
    //         window.history.replaceState({path:currentURL},'',currentURL)
    //         console.log(document.URL)
    //         break;
    //     case "sort-name":
    //         columnToSort = "ticketName"
    //         window.history.replaceState({path:currentURL},'',currentURL)
    //         break;
    //     case "sort-status":
    //         columnToSort = "ticketStatus"
    //         window.history.replaceState({path:currentURL},'',currentURL)
    //         break;
    //     case "sort-priority":
    //         columnToSort = "ticketPriority"
    //         window.history.replaceState({path:currentURL},'',currentURL)
    //         break;
    //     case "sort-severity":
    //         columnToSort = "ticketSeverity"
    //         window.history.replaceState({path:currentURL},'',currentURL)
    //         break;
    //     case "sort-modified":
    //         columnToSort = "updatedAt"
    //         window.history.replaceState({path:currentURL},'',currentURL)
    //         break;
    //     case "sort-assignee":
    //         columnToSort = "assignee"
    //         window.history.replaceState({path:currentURL},'',currentURL)
    //         break;
    // }

    // CREATES A QUERY PARAMETER
    // IMPORTANT: As much as possible, do not rename your request parameter as same as member variable of an object to avoid type error 
    var queryParam = '?proj=' + checkedValuesProj.join(',') + '&type=' + checkedValuesType.join(',') 
                    + '&status=' + checkedValuesStatus.join(',') + '&prio=' + checkedValuesPriority.join(',')
                    + '&severity=' + checkedValuesSeverity.join(',') + '&assigned=' + checkedValuesAssignee.join(',')
                    //+ '&orderBy='
                    // creates query param

    
    //window.location.href="http://localhost:8080/?"+queryParam;

    var currentURL = window.location.protocol + "//" + window.location.host + window.location.pathname + queryParam;
    window.history.replaceState({path:currentURL},'',currentURL)
    
    


    // $("#btn-clear-filter").click(function(){
    //     queryParam="?proj=&type=&status=&prio=&severity=&assigned="
    //     currentURL = window.location.protocol + "//" + window.location.host + window.location.pathname + queryParam;
    //     window.location.href=currentURL
    //     $('input[type="checkbox"]').prop('checked', false)
    // })
    
});

$("#btn-submit-filter").click(function(){
    window.location.href = document.URL;
})

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


// Count the current number of chars in Ticket Name field
// var currentLength = $('.issuePropInputText').attr("value").length;
// console.log(currentLength)

$('.input-tkt-name').on("input", function(e){
    var target = e.target
    var tktNameCurrentLength = target.value.length;
    var tktDescCurrentLength = $('.input-tkt-desc').val().length
    
    $('.input-tkt-name').blur(function(e){
        // Prevents ticket name to be submitted when blank
        // console.log(tktNameCurrentLength)
        if(tktNameCurrentLength!=0 && tktDescCurrentLength!=0){
            
            $('form#issuePropForm').submit()
        }
        
    })
    
    // console.log(tktNameCurrentLength)
})

$(".input-tkt-desc").blur(function(){
    var tktNameCurrentLength = $('.input-tkt-name').val().length
    var tktDescCurrentLength = $('.input-tkt-desc').val().length

    // Prevent empty ticket form fields to be submitted when blank
    if(tktNameCurrentLength!=0){
        console.log("test")
        $('form#issuePropForm').submit()
    }
})


// Prevent Button to enable when comment field is empty
$(".tkt-new-comment").on("input", function(e){
    var newCommentCurrentLength = e.target.value.length;

    if(newCommentCurrentLength>0){
        $(".new-cmt-submit-btn").removeAttr("disabled")
        // console.log("empty")
    } else if (newCommentCurrentLength==0){
        $(".new-cmt-submit-btn").attr("disabled", "true")
    }

})

$(".edit-comment-form").on("input", function(e){
    var editCommentCurrentLength = e.target.value.length;

    if(editCommentCurrentLength>0){
        $(".edit-cmt-submit-btn").removeAttr("disabled")
        // console.log("empty")
    } else if (editCommentCurrentLength==0){
        $(".edit-cmt-submit-btn").attr("disabled", "true")
    }
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
    var commentContent = $(this).parent().prev()
    var editCommentForm = $(this).closest(".edit-comment-form")
    
    editCommentForm.css("display", "none")
    
    // Restore current edit comment field value when cancel button is clicked
    $('.edit-cmt-textcontent').val(commentContent.html())
    
    commentContent.css("display", "initial")
    
    
    
})

$(".btn-lc-sorter-to-asc").click(function(){

    
    var orderDirection = "ASC"

    switch (this.id)
    {
        case "sort-key":
            // code here
            window.location.href = document.URL + "&orderBy=ticketKey&orderIn=" + orderDirection
            break;
        case "sort-type":
            // code here
            window.location.href = document.URL + "&orderBy=ticketType&orderIn=" + orderDirection
            break;
        case "sort-name":
            // code here
            window.location.href = document.URL + "&orderBy=ticketName&orderIn=" + orderDirection
            break;
        case "sort-status":
            // code here
            window.location.href = document.URL + "&orderBy=ticketStatus&orderIn=" + orderDirection
            break;
        case "sort-priority":
            // code here
            window.location.href = document.URL + "&orderBy=ticketPriority&orderIn=" + orderDirection
            break;
        case "sort-severity":
            // code here
            window.location.href = document.URL + "&orderBy=ticketSeverity&orderIn=" + orderDirection
            break;
        case "sort-modified":
            // code here
            window.location.href = document.URL + "&orderBy=updatedAt&orderIn=" + orderDirection
            break;
        // case "sort-assignee":
        //     // code here
        //     console.log(8)
        //     break;
    }
})

$(".btn-lc-sorter-to-desc").click(function(){

    
    var orderDirection = "DESC"

    switch (this.id)
    {
        case "sort-key":
            // code here
            window.location.href = document.URL + "&orderBy=ticketKey&orderIn=" + orderDirection
            break;
        case "sort-type":
            // code here
            window.location.href = document.URL + "&orderBy=ticketType&orderIn=" + orderDirection
            break;
        case "sort-name":
            // code here
            window.location.href = document.URL + "&orderBy=ticketName&orderIn=" + orderDirection
            break;
        case "sort-status":
            // code here
            window.location.href = document.URL + "&orderBy=ticketStatus&orderIn=" + orderDirection
            break;
        case "sort-priority":
            // code here
            window.location.href = document.URL + "&orderBy=ticketPriority&orderIn=" + orderDirection
            break;
        case "sort-severity":
            // code here
            window.location.href = document.URL + "&orderBy=ticketSeverity&orderIn=" + orderDirection
            break;
        case "sort-modified":
            // code here
            window.location.href = document.URL + "&orderBy=updatedAt&orderIn=" + orderDirection
            break;
        // case "sort-assignee":
        //     // code here
        //     console.log(8)
        //     break;
    }
})

$(document).ready(function(){

// Paginate Ticket List
$('#main-tab-lc').after('<div id="pagi-counts-lc"></div>');
    var rowsShown = 15;
    var rowsTotal = $('#main-tab-lc tbody tr').length;
    var numPages = rowsTotal/rowsShown;
    for(i = 0;i < numPages;i++) {
        var pageNum = i + 1;
        $('#pagi-counts-lc').append('<a href="#" rel="'+i+'">'+pageNum+'</a> ');
    }
    $('#main-tab-lc tbody tr').hide();
    $('#main-tab-lc tbody tr').slice(0, rowsShown).show();
    $('#pagi-counts-lc a:first').addClass('active');
    $('#pagi-counts-lc a').on('click', function(){
        console.log("click")
        $('#pagi-counts-lc a').removeClass('active');
        $(this).addClass('active');
        var currPage = $(this).attr('rel');
        var startItem = currPage * rowsShown;
        var endItem = startItem + rowsShown;
        $('#main-tab-lc tbody tr').css('opacity','0.0').hide().slice(startItem, endItem).
        css('display','table-row').animate({opacity:1}, 300);
    });
})








// $("#regform-roles").change(()=>{
//     console.log($("#regform-roles").val())
//     console.log($("#regform-roles").attr("action"))
// })






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