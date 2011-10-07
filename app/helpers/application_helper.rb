module ApplicationHelper

def general_nav(user)
  if user
    render :partial => "layouts/usernav"
  else
    render :partial => "layouts/guestnav"
  end
end

def quick_nav(user)
  if user
    render :partial => "layouts/userquicknav"
  else
    render :partial => "layouts/guestquicknav"
  end
end

end
