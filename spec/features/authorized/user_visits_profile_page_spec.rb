describe "User visits profile page and" do
  scenario "sees their name and profile image" do
    stub_omniauth
    visit "/"
    assert_equal 200, page.status_code
    click_link("Login with Github")

    user = User.last

    click_link("Profile")

    expect(current_path).to eq authorized_profile_path
    expect(page).to have_content(user.name)
    expect(page).to have_css("img[src*=\"#{user.image_url}\"]")
  end

  scenario "sees their starred repos, followers, and following" do
    stub_omniauth
    visit "/"
    assert_equal 200, page.status_code
    click_link("Login with Github")

    user = User.last

    click_link("Profile")

    expect(current_path).to eq authorized_profile_path
  end
end
