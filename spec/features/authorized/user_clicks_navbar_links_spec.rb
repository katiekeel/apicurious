describe "User clicks navbar links and" do
  context "is logged in and" do
    scenario "is redirected to their profile page" do
      stub_omniauth
      visit "/"
      assert_equal 200, page.status_code
      click_link("Login with Github")

      click_link("Profile")

      expect(current_path).to eq authorized_profile_path
    end

    scenario "is redirected to their repos page" do
      stub_omniauth
      visit "/"
      assert_equal 200, page.status_code
      click_link("Login with Github")

      click_link("Your Repos")

      expect(current_path).to eq authorized_repos_path
    end

    scenario "is redirected to their activity page" do
      stub_omniauth
      visit "/"
      assert_equal 200, page.status_code
      click_link("Login with Github")

      click_link("Your Recent Activity")

      expect(current_path).to eq authorized_activity_path
    end

    scenario "is redirected to their followers' activity page" do
      stub_omniauth
      visit "/"
      assert_equal 200, page.status_code
      click_link("Login with Github")

      click_link("Following Activity")

      expect(current_path).to eq authorized_following_activity_path
    end

    scenario "is redirected to their organizations page" do
      stub_omniauth
      visit "/"
      assert_equal 200, page.status_code
      click_link("Login with Github")

      click_link("Organizations")

      expect(current_path).to eq authorized_organizations_path
    end
  end

  context "is logged out and" do
    scenario "is returned to home page" do
      stub_omniauth
      visit "/"
      assert_equal 200, page.status_code
      click_link("Login with Github")

      click_link("Logout")

      expect(current_path).to eq "/"
    end

    scenario "does not see the dropdown menu" do
      stub_omniauth
      visit "/"
      assert_equal 200, page.status_code
      click_link("Login with Github")

      click_link("Logout")

      expect(page).to_not have_link("Your Stuff")
      expect(page).to_not have_link("Profile")
      expect(page).to_not have_link("Your Repos")
      expect(page).to_not have_link("Your Recent Activity")
      expect(page).to_not have_link("Following Activity")
      expect(page).to_not have_link("Organizations")
    end
  end
end
