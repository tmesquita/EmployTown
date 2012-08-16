module ApplicationHelper

# def general_nav(user)
#   if user
#     if user.is_job_seeker?
#       render :partial => "layouts/seekernav"
#     elsif user.is_employer?
#       render :partial => "layouts/employernav"
#     end
#   else
#     render :partial => "layouts/guestnav"
#   end
# end

# def quick_nav(user)
#   if user
#     if user.is_job_seeker?
#       render :partial => "layouts/seekerquicknav"
#     elsif user.is_employer?
#       render :partial => "layouts/employerquicknav"
#     end
#   else
#     render :partial => "layouts/guestquicknav"
#   end
# end

def search(user)
  if user
    if user.is_employer?
      render :partial => "layouts/search"
    end
  end
end

def root_path_for(user)
  return job_seekers_root_path if user.is_job_seeker?
  return employers_root_path if user.is_employer?
  root_path
end

# def flash_heading(flash)
#   return 'Success' if flash[:success]
#   return 'Error!' if flash[:error]
# end

end
