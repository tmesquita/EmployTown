$(document).ready ->

  # @original_text = ''

  $('body').on 'click', '.bid a', (e) ->
    unless $(@).hasClass('cancel')
      e.stopPropagation()

  $('body').on 'click', '.bid .read-more', ->
    id = $(@).data('bid-id')
    $read_more = $(@)
    @original_text = $read_more.parent().find('p').text().replace(/\n/g, "<br/>")
    $.ajax
      url: "job_seekers/bids/#{id}"
      dataType: 'json'
      type: 'GET'
      success: (data) ->
        $read_more.parent().find('p').html(data.job_description.replace(/\n/g,"<br/>"))
        $read_more.removeClass('read-more').addClass('less-link').text('Less')

  $('body').on 'click', '.bid .less-link', ->
    $less_link = $(@)
    $less_link.parent().find('p').html(@original_text)
    $less_link.removeClass('less-link').addClass('read-more').text('Read more')

  $('body').on 'click', '.bid', ->
    $arrows = $(@).find('.arrow')
    $detailsBox = $(@).find('.detailsBox')
    $thumb = $(@).find('.image, .action-button.main')
    $arrows.toggle()
    $detailsBox.toggle()
    $thumb.toggle()