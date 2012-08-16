module BidsHelper

  def more_link(h)
    if !h.job_description.nil? and h.job_description.length > 200
      link_to_function("Read More", nil, :id => "1") do |page|
        page["bid#{h.id}"].replace_html "#{simple_format(h.job_description)}"
        page.insert_html :after, "more#{h.id}", "<div class='less' id='less#{h.id}'>#{less_link(h)}</div>"
        page.hide "more#{h.id}"
      end
    end
  end

  def less_link(h)
    link_to_function("Less", nil, :id => "1") do |page|
      page["bid#{h.id}"].replace_html "#{truncate(h.job_description, :length => 200, :omission => '... (continued)')}"
      page.show "more#{h.id}"
      page.hide "less#{h.id}"
    end
  end

end
