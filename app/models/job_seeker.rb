class JobSeeker < User
  authenticates_with_sorcery!

  has_many :bids

  default_scope conditions: { role_id: Role.job_seeker.id }

  def to_param
    user_url
  end

  def has_bid_from_employer?(user)
    Bid.where(:employer_id => user.id, job_seeker_id: self.id).count > 0 unless user.nil?
  end

  def self.search(search)
    search.upcase
    where("first_name LIKE UPPER(?) OR last_name LIKE UPPER(?) OR first_name || ' ' || last_name LIKE UPPER(?) OR email LIKE UPPER(?)", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
  end
end