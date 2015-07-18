$ ->
  $('button#add-tag').on 'click', ->
    $(this).toggle()
    $('#tag-form').toggle()
    return


