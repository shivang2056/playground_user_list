require "./test/application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = User.find_by_name('Dax Walker')
  end

  test "Creating a new user" do
    visit users_path

    assert_selector "a", text: "New User"

    click_on "New User"

    assert_selector("#user_name")

    fill_in "Name", with: "Example Name"
    fill_in "Email", with: "Example@email.com"
    fill_in "Age", with: "45"
    fill_in "Phone", with: "98765"
    select "Dr.", from: "user_detail_attributes_title"
    click_on "Create User"

    assert_text "Example Name"

    click_on "Example Name"

    assert 'Example@email.com', find("input#user_detail_attributes_email").value
    assert '45', find("input#user_detail_attributes_age").value
    assert '98765', find("input#user_detail_attributes_phone").value
    assert 'Dr.', find("select#user_detail_attributes_title").value
  end

  test "Updating user" do
    visit users_path

    assert_selector "a", text: @user.name

    click_on @user.name

    assert_selector("#user_name")

    fill_in "Name", with: "Dax Walker New"
    fill_in "Age", with: "22"
    fill_in "Email", with: "dax@walker.com"
    fill_in "Phone", with: "12345"
    select "Prof.", from: "user_detail_attributes_title"

    click_on "Update User"
    click_on "Dax Walker New"

    assert '22', find("input#user_detail_attributes_age").value
    assert 'dax@walker.com', find("input#user_detail_attributes_email").value
    assert '12345', find("input#user_detail_attributes_phone").value
    assert 'Prof.', find("select#user_detail_attributes_title").value
  end

  test "Destroying user" do
    visit users_path
    assert_text @user.name

    find_link(text: @user.name).sibling('div').click_button

    assert_no_text @user.name
  end

  test "Searching for user" do
    visit users_path

    fill_in "name", with: "Brad"
    click_on "Search"

    assert_text "Brad Bauch"
  end

  test "Error handling when name & email are not present." do
    visit users_path

    click_on "New User"

    assert_selector("#user_name")

    # Disable HTML form validation.
    execute_script("document.querySelector(\".container form[action='/users']\").noValidate= true")

    click_on "Create User"

    assert "Detail email can't be blank and name can't be blank", find(".container form[action='/users'] span").text
  end
end