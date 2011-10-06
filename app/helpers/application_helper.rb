module ApplicationHelper

def quicknav(user)
  if user
    render :partial => "layouts/userquicknav"
  else
    render :partial => "layouts/guestquicknav"
  end
end

end
