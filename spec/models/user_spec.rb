require 'rails_helper'

RSpec.describe User, type: :model do
  context "Validations" do
    context "Attributes" do
      it {should validate_presence_of(:name)}
      it {should validate_presence_of(:email)}
      it {should validate_presence_of(:provider)}
      it {should validate_presence_of(:uid)}
      it {should validate_presence_of(:screen_name)}
      it {should validate_presence_of(:oauth_token)}
      it {should validate_presence_of(:image_url)}
    end
  end

  scenario "creates/updates from OAuth" do
    auth = {
       "provider" => "github",
            "uid" => "12345678",
           "info" => {
              "nickname" => "katiekeel",
                 "email" => "akatiekeel@gmail.com",
                  "name" => "Katie Keel",
                 "image" => "https://avatars2.githubusercontent.com/u/11282627?v=4"
              },
            "credentials" => {
                  "token" => "12345678"
              }
            }
    User.find_or_create_by_auth(auth)
    user = User.first

    expect(user.provider).to eq(auth["provider"])
    expect(user.uid).to eq(auth["uid"])
    expect(user.email).to eq(auth["info"]["email"])
    expect(user.name).to eq(auth["info"]["name"])
    expect(user.oauth_token).to eq(auth["credentials"]["token"])
    expect(user.screen_name).to eq(auth["info"]["nickname"])
    expect(user.image_url).to eq(auth["info"]["image"])
  end
end
