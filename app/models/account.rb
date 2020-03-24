class Account < ApplicationRecord
  RESERVED_SUBDOMAINS = %w(
    admin help support mail test staging pre-production production qa
  )

  has_many :account_memberships, class_name: "AccountMember"
  has_many :users, through: :account_memberships

  before_validation :set_subdomain, on: :create

  validates :name, :subdomain, presence: true, uniqueness: true
  validate :validate_subdomain_against_reservered_domains

  private

  def validate_subdomain_against_reservered_domains
    return unless RESERVED_SUBDOMAINS.include?(name.downcase)
    errors.add(:subdomain, "is not available")
  end

  def set_subdomain
    self.subdomain ||= name.downcase.parameterize
  end
end
