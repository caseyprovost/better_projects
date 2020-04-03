# require "test_helper"

# class ProjectsControllerTest < ActionController::TestCase
#   setup do
#     @user = create(:user, :confirmed)
#     @account = create(:account, name: "drow")
#     create(:account_member, account: @account, user: @user)
#     @request.env["devise.mapping"] = Devise.mappings[:users]
#     @controller.stubs(:current_account).returns(@account)
#     @controller.stubs(:current_user).returns(@user)
#     sign_in(@user)
#   end

#   test "should create a project" do
#     post :create, params: {
#       project: {
#         name: "dwarves",
#         description: "A place fully of beer and small beareded folk"
#       }
#     }

#     project = Project.find_by(name: "dwarves")
#     assert project.present?
#     assert_redirected_to project_path(project)
#   end

#   test "should handle invalid create requests" do
#     post :create, params: {
#       project: {
#         name: "dwarves"
#       }
#     }

#     project = Project.find_by(name: "dwarves")
#     assert project.nil?
#     assert_redirected_to account_dashboard_path(@account)
#     assert session[:errors].messages[:description].include?("can't be blank")
#   end
# end
