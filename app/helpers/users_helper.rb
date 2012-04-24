module UsersHelper
  def more_about_me(h)
    if !h.about_me.nil? and h.about_me.length > 500
      link_to_function("Read More", nil, :id => "1") do |page|
        page["about_me"].replace_html "#{simple_format(h.about_me)}"
        page.insert_html :after, "about_more", "<div id='about_less'>#{less_about_me(h)}</div>"
        page.hide "about_more"
      end
    end
  end

  def less_about_me(h)
    link_to_function("Less", nil, :id => "1") do |page|
      page["about_me"].replace_html "#{truncate(h.about_me, :length => 500, :omission => '... (continued)')}"
      page.show "about_more"
      page.hide "about_less"
    end
  end

  def more_value(h)
    if !h.ideal_role.nil? and h.ideal_role.length > 500
      link_to_function("Read More", nil, :id => "1") do |page|
        page["add_value"].replace_html "#{simple_format(h.ideal_role)}"
        page.insert_html :after, "value_more", "<div id='value_less'>#{less_value(h)}</div>"
        page.hide "value_more"
      end
    end
  end

  def less_value(h)
    link_to_function("Less", nil, :id => "1") do |page|
      page["add_value"].replace_html "#{truncate(h.ideal_role, :length => 500, :omission => '... (continued)')}"
      page.show "value_more"
      page.hide "value_less"
    end
  end

  def more_about_with_id(h, length)
    if !h.about_me.nil? and h.about_me.length > length
      link_to_function("Read More", nil, :id => "1") do |page|
        page["about_me#{h.id}"].replace_html "#{simple_format(h.about_me)}"
        page.insert_html :after, "about_more#{h.id}", "<div id='about_less#{h.id}' class='about_less'>#{less_about_with_id(h, length)}</div>"
        page.hide "about_more#{h.id}"
      end
    end
  end

  def less_about_with_id(h, length)
    link_to_function("Less", nil, :id => "1") do |page|
      page["about_me#{h.id}"].replace_html "#{truncate(h.about_me, :length => length, :omission => '... (continued)')}"
      page.show "about_more#{h.id}"
      page.hide "about_less#{h.id}"
    end
  end

  def more_about_tag(u, t, length)
    if !u.about_me.nil? and u.about_me.length > length
      link_to_function("Read More", nil, :id => "1") do |page|
        page["about_me#{u.id}#{t.id}"].replace_html "#{simple_format(u.about_me)}"
        page.insert_html :after, "about_more#{u.id}#{t.id}", "<div id='about_less#{u.id}#{t.id}' class='about_less'>#{less_about_tag(u, t, length)}</div>"
        page.hide "about_more#{u.id}#{t.id}"
      end
    end
  end

  def less_about_tag(u, t, length)
    link_to_function("Less", nil, :id => "1") do |page|
      page["about_me#{u.id}#{t.id}"].replace_html "#{truncate(u.about_me, :length => length, :omission => '... (continued)')}"
      page.show "about_more#{u.id}#{t.id}"
      page.hide "about_less#{u.id}#{t.id}"
    end
  end
end
