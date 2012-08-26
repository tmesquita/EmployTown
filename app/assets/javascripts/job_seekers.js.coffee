$(document).ready ->

  # Fix for images that aren't completely 50x50
  $('.image img').load ->
    $height = $(@).height()
    margin = 50 - $height
    if margin > 0
      $(@).css('margin-top', margin / 2)