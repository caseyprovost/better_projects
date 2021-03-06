class Account < ApplicationRecord
  RESERVED_SUBDOMAINS = %w[
    admin app help support mail test staging pre-production production qa www
  ]

  attribute :owner

  has_many :account_memberships, class_name: "AccountMember", dependent: :destroy
  has_many :users, through: :account_memberships
  has_many :projects
  has_many :buckets

  before_validation :set_subdomain, on: :create
  before_create :add_owner

  validates :name, :subdomain, presence: true, uniqueness: true
  validates :subdomain, format: {
    with: /\A[a-zA-Z]*\z/,
    if: -> { subdomain_changed? },
    message: "Only letters can be used in subdomains"
  }
  validate :validate_subdomain_against_reservered_domains

  private

  def add_owner
    return true if owner.nil?

    account_memberships.build(
      user: owner,
      role: AccountRole.find_or_create_by(name: "Owner"),
      account: self
    )
  end

  def validate_subdomain_against_reservered_domains
    return unless RESERVED_SUBDOMAINS.include?(name.downcase)
    errors.add(:subdomain, "is not available")
  end

  def set_subdomain
    self.subdomain ||= name.downcase.gsub(/\s/, "")
  end
end
