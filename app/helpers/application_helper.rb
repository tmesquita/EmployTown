module ApplicationHelper

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

end
