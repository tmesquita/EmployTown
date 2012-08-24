module CompaniesHelper
  def submit_button_text
    return 'Create' if params[:action].eql? 'new'
    'Update'
  end
end
