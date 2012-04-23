module UsersHelper
  def more_about_me(h)
    if h.about_me.length > 200
      link_to_function("Read More", nil, :id => "1") do |page|
        page["about_me"].replace_html "#{simple_format(h.about_me)}"
        page.insert_html :after, "about_more", "<div id='about_less'>#{less_about_me(h)}</div>"
        page.hide "about_more"
      end
    end
  end

  def less_about_me(h)
    link_to_function("Less", nil, :id => "1") do |page|
      page["about_me"].replace_html "#{truncate(h.about_me, :length => 500)}"
      page.show "about_more"
      page.hide "about_less"
    end
  end

  def more_value(h)
    if h.ideal_role.length > 200
      link_to_function("Read More", nil, :id => "1") do |page|
        page["add_value"].replace_html "#{simple_format(h.ideal_role)}"
        page.insert_html :after, "value_more", "<div id='value_less'>#{less_value(h)}</div>"
        page.hide "value_more"
      end
    end
  end

  def less_value(h)
    link_to_function("Less", nil, :id => "1") do |page|
      page["add_value"].replace_html "#{truncate(h.ideal_role, :length => 500)}"
      page.show "value_more"
      page.hide "value_less"
    end
  end
end
