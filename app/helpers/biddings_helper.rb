module BiddingsHelper

  def more_link(h)
    if h.comment.length > 200
      link_to_function("Read More", nil, :id => "1") do |page|
        page["bid#{h.id}"].replace_html "#{simple_format(h.comment)}"
        page.insert_html :after, "more#{h.id}", "<div class='less' id='less#{h.id}'>#{less_link(h)}</div>"
        page.hide "more#{h.id}"
      end
    end
  end

  def less_link(h)
    link_to_function("Less", nil, :id => "1") do |page|
      page["bid#{h.id}"].replace_html "#{truncate(h.comment, :length => 200)}"
      page.show "more#{h.id}"
      page.hide "less#{h.id}"
    end
  end

end
