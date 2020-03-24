# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin_role = AccountRole.find_or_create_by(name: "Admin")

if Rails.env.development?
  account = Account.find_or_create_by(name: "avengers")
  user = User.find_or_create_by(name: "Bruce Banner", email: "hulk@avengers.net")
  user.confirm && user.save!

  AccountMember.find_or_create_by(account_id: account.id, user_id: user.id, role_id: admin_role.id)
end
