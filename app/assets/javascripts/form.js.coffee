$(document).ready ->

  unless Modernizr.input.placeholder
    $('[placeholder]').focus ->
      input = $(@)
      if input.val() == input.attr('placeholder')
        input.val('')
        input.removeClass('placeholder')

    .blur ->
      input = $(@)
      if input.val() == '' || input.val() == input.attr('placeholder')
        input.addClass('placeholder')
        input.val(input.attr('placeholder'))
    .blur()

    $('[placeholder]').parents('form').submit ->
      $(@).find('[placeholder]').each ->
        input = $(@)
        if input.val() == input.attr('placeholder')
          input.val('')
