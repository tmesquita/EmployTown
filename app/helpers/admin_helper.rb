module AdminHelper
  def dropdown_menu_for(user)
    return render 'layouts/job_seeker_menu' if user.is_job_seeker?
    return render 'layouts/employer_menu' if user.is_employer?
  end

  def navbar_for(user)
    return render 'layouts/job_seeker_nav' if user.is_job_seeker?
    return render 'layouts/employer_nav' if user.is_employer?
  end
end