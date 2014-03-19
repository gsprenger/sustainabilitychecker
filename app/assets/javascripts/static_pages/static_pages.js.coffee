class window.StaticPages
  @setup: ->
    $('#btnsubmit').click ->
      setTimeout ->
        $('#btnsubmit').attr('disabled', 'disabled')
      , 10
      $('#btnsubmit').val('Sending...')
    $('form#formcontact').bind 'ajax:success', (evt, data, status, xhr) ->
        $('#btnsubmit').removeClass("btn-default")
        if xhr.responseText == "success"
          $('#btnsubmit').addClass("btn-success")
          $('#btnsubmit').val('Sent!')
        else if xhr.responseText == "failure"
          $('#btnsubmit').addClass("btn-danger")
          $('#btnsubmit').val('Failure. Please retry.')
        $('#btnsubmit').removeAttr('disabled')
