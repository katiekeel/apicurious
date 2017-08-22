describe "User is logged out and" do
  scenario "clicks the login link in the navbar" do
    stub_omniauth
    visit "/"
    assert_equal 200, page.status_code
    click_link("Login with Github")
  end
end
