class Employer < User
  authenticates_with_sorcery!
  
  belongs_to :company
  has_many :bids

  default_scope conditions: { role_id: Role.employer.id }

  def add_company(company_id)
    update_attributes(company_id: company_id)
  end

  def belongs_to_company?
    !company.nil?
  end
end