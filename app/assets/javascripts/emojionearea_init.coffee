$(document).on 'turbolinks:load', ->
  $("#wish_body").emojioneArea
    autoHideFilters: true
    events: keypress: (editor, event) ->
      if event.which is 13 && !event.shiftKey
        $("#wish_body").val $('#wish_body').data('emojioneArea').getText()
        $('#new_wish').submit()
        $('#wish_body').data('emojioneArea').setText ""
        event.preventDefault()
      return
