$(document).ready ->

  $('body').on 'click', '.result a', (e) ->
    e.stopPropagation()

  $('body').on 'click', '.result', ->
    $arrows = $(@).find('.arrow')
    $detailsBox = $(@).find('.detailsBox')
    $thumb = $(@).find('.image, .action-button.main')
    $arrows.toggle()
    $detailsBox.toggle()
    $thumb.toggle()



