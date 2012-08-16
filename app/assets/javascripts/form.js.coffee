$(document).ready ->

  $window_height_original = $(window).height()

  $container_offset = $('.container').offset()
  $footer_offset = $('.footer').offset()
  $height = $footer_offset.top - $container_offset.top
  # $('.container').height($height)
  # $('.form-container').height($height - 40)


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
