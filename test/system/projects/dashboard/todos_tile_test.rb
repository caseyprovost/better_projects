require 'test_helper'

class TodosTileTest < ApplicationSystemTestCase
  include SystemTestHelper

  setup do
    @user = create(:user, :confirmed, name: "Bruce Banner")
    @account = create(:account, name: "avengers", owner: @user)
    @project = create(:project, account: @account, name: "Save the world", creator: @user)
    @bucket = @project.bucket
    add_user_to_project(@user, @project)
    Capybara.app_host = "http://#{@account.subdomain}.lvh.me"
    sign_in(@user)
    visit project_path(@project)
    assert_text "To-dos"
  end

  test "diplays the empty state" do
    assert_text "Make lists of work to be done"
  end

  test "prompts the user to create their first todo list, when none exist" do
    find(:link, text: "To-dos").click
    assert_text "Create your first to-do"
    assert current_path bucket_todo_set_path(@bucket, @bucket.todo_sets.first)
  end

  test "displays todo list previews when todo lists exist" do
    create(:todo_list, creator: @user, parent: @bucket.todo_sets.first, title: "Groceries")
    visit project_path(@project)

    assert_text "To-dos" # All projects start with a TodoSet with a title of "To-dos"
    assert_text "Groceries"
  end

  test "goes to the todo set page and displays all lists" do
    create(:todo_list, creator: @user, parent: @bucket.todo_sets.first, title: "Groceries")
    visit project_path(@project)

    find(:link, text: "Message Board").click
    assert_text "Message Board"
    assert_text "Testing"
    assert_text "battle!"
  end
end
