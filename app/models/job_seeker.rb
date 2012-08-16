class JobSeeker < User
  authenticates_with_sorcery!

  has_many :bids

  default_scope conditions: { role_id: Role.job_seeker.id }

  def has_bid_from_employer?(user)
    Bid.where(:employer_id => user.id).count > 0 unless user.nil?
  end
end