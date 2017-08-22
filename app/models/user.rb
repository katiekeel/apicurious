class User < ApplicationRecord
  validates_presence_of :name, :email, :provider, :uid, :screen_name, :oauth_token, :image_url

  def self.find_or_create_by_auth(auth)
    user = User.find_or_create_by(provider: auth['provider'], uid: auth['uid'])

    user.provider = auth['provider']
    user.name = auth['info']['name']
    user.email = auth['info']['email']
    user.uid = auth['uid']
    user.screen_name = auth['info']['nickname']
    user.oauth_token = auth['credentials']['token']
    user.image_url = auth['info']['image']

    user.save
    user
  end
end
