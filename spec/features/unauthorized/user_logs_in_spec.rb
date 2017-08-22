describe "User logs in and" do
  scenario "is redirected to their profile page" do
    stub_omniauth
    visit "/"
    assert_equal 200, page.status_code
    click_link("Login with Github")

    user = User.first

    expect(current_path).to eq authorized_profile_path
    expect(page).to have_content("Logout")
    expect(page).to_not have_link("Login with Github")
  end
end
