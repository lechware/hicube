//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery-ui
//= require turbolinks
//= require twitter/bootstrap
//= require jquery-fileupload

//= require dataTables/jquery.dataTables
//= require dataTables/bootstrap/3/jquery.dataTables.bootstrap
//= require dataTables/extras/dataTables.responsive
//= require icheck
//= require codemirror
//= require codemirror/modes/xml
//= require codemirror/modes/htmlembedded
//= require codemirror/modes/htmlmixed
//= require codemirror/modes/coffeescript
//= require codemirror/modes/javascript
//= require codemirror/modes/ruby
//= require codemirror/modes/markdown
//= require codemirror/modes/slim
//= require codemirror/addons/selection/active-line

// Adminlte and corresponding Plugins
//= require adminlte

//= require_tree .

$(function () {
  $('input').iCheck({
    checkboxClass: 'icheckbox_minimal-blue',
    radioClass: 'iradio_flat-blue',
    increaseArea: '20%' // optional
  });

  $('#datatable').dataTable({
    "bSort": false
  });

  var editor = CodeMirror.fromTextArea(document.getElementById("textarea"), {
    lineNumbers: true,
    mode: "application/x-slim",
    matchBrackets: true,
    tabSize: 2,
    indentWithTabs: true,
    lineWrapping: true,
    styleActiveLine: true
  });


});
window.setTimeout(function() { $(".alert-info").alert('close'); }, 4000);
window.setTimeout(function() { $(".alert-success").alert('close'); }, 4000);
