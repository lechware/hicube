//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require turbolinks
//= require twitter/bootstrap
//= require admin-lte
// require pagedown_bootstrap
// require pagedown_init
//= require hicube/pagedown-bootstrap/pagedown_bootstrap
//= require hicube/pagedown-bootstrap/pagedown_init
//= require dataTables/jquery.dataTables
//= require dataTables/bootstrap/3/jquery.dataTables.bootstrap
//= require dataTables/extras/dataTables.responsive
//= require_tree .

// $(function() {
//   return $('textarea.wmd-input').each(function(i, input) {
//     var attr, converter, editor, help;
//     attr = $(input).attr('id').split('wmd-input')[1];
//     converter = new Markdown.Converter();
//     // converter.hooks.chain("plainLinkText", function (url) {
//     //   if (/^http:\/\/\w+\.imageurl/i.test(url))
//     //     return "{%img_tag FILENAME%}";
//     //   else
//     //     return url;
//     // });
//     Markdown.Extra.init(converter);
//     // help = {
//     //   handler: function() {
//     //     window.open('http://daringfireball.net/projects/markdown/syntax');
//     //     return false;
//     //   },
//     //   title: "<%= I18n.t('components.markdown_editor.help', default: 'Markdown Editing Help') %>"
//     // };
//     editor = new Markdown.Editor(converter, attr, help);
    
//     editor.hooks.set("insertImageDialog", function (callback) {
//       setTimeout(function () { callback("{img_tag\ FILENAME}"); }, 0);
//       return true;
//     });
//     return editor.run();
//   });
// });
