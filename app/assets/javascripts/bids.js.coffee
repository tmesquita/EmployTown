$(document).ready ->

  $('body').on 'click', '.bid', ->
    $arrows = $(@).find('.arrow')
    $detailsBox = $(@).find('.detailsBox')
    $thumb = $(@).find('.image, .action-button.main')
    $arrows.toggle()
    $detailsBox.toggle()
    $thumb.toggle()