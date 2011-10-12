module ApplicationHelper

def general_nav(user)
  if user
    if user.is_seeker?
      render :partial => "layouts/seekernav"
    elsif user.is_employer?
      render :partial => "layouts/employernav"
    end
  else
    render :partial => "layouts/guestnav"
  end
end

def quick_nav(user)
  if user
    if user.is_seeker?
      render :partial => "layouts/seekerquicknav"
    elsif user.is_employer?
      render :partial => "layouts/employerquicknav"
    end
  else
    render :partial => "layouts/guestquicknav"
  end
end

def search(user)
  if user
    if user.is_employer?
      render :partial => "layouts/search"
    end
  end
end

end
