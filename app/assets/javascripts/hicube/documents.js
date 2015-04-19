// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$("document").ready(function(){

  $("#file-upload").change(function() {
    var filename = $(this).val().split('\\').pop();
    $("#file-name").val(filename);
  });

});