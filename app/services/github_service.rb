class GithubService

  attr_reader :user

  def initialize(user)
    @user = user
    @conn = Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers["X-API-KEY"] = ENV["GITHUB_CLIENT_ID"]
      faraday.adapter Faraday.default_adapter
    end
  end

  def get_url(url)
    response = @conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.find_starred_repos(user)
    new(user).find_starred_repos
  end

  def find_starred_repos
    get_url("/users/#{user}/starred?client_id=#{ENV["GITHUB_CLIENT_ID"]}&client_secret=#{ENV["GITHUB_CLIENT_SECRET"]}")
  end

  def self.find_followers(user)
    new(user).find_followers
  end

  def find_followers
    get_url("/users/#{user}/followers?client_id=#{ENV["GITHUB_CLIENT_ID"]}&client_secret=#{ENV["GITHUB_CLIENT_SECRET"]}")
  end

  def self.find_following(user)
    new(user).find_following
  end

  def find_following
    get_url("/users/#{user}/following?client_id=#{ENV["GITHUB_CLIENT_ID"]}&client_secret=#{ENV["GITHUB_CLIENT_SECRET"]}")
  end

  def self.find_organizations(user)
    new(user).find_organizations
  end

  def find_organizations
    get_url("/users/#{user}/orgs?client_id=#{ENV["GITHUB_CLIENT_ID"]}&client_secret=#{ENV["GITHUB_CLIENT_SECRET"]}")
  end

  def self.find_repos(user)
    new(user).find_repos
  end

  def find_repos
    get_url("/users/#{user}/repos?client_id=#{ENV["GITHUB_CLIENT_ID"]}&client_secret=#{ENV["GITHUB_CLIENT_SECRET"]}")
  end

end
