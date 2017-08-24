class GithubService

  attr_reader :user
              :events_conn

  def initialize(user)
    @user = user
    @conn = Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers["X-API-KEY"] = ENV["GITHUB_CLIENT_ID"]
      faraday.adapter Faraday.default_adapter
    end
    @events_conn = Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.headers["X-API-KEY"] = ENV["GITHUB_CLIENT_ID"]
      faraday.headers["Accept"] = "application/vnd.github.cloak-preview"
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

  def self.find_events(user)
    new(user).find_events
  end

  def find_events
    get_events_url("/search/commits?q=author%3Akatiekeel&sort=author-date&per_page=800&client_id=#{ENV["GITHUB_CLIENT_ID"]}&client_secret=#{ENV["GITHUB_CLIENT_SECRET"]}")
  end

  def get_events_url(url)
    response = @events_conn.get(url)
    results = JSON.parse(response.body, symbolize_names: true)
    new_results = []
    results[:items].each {|commit| new_results << {:date => commit[:commit][:author][:date].to_date, :repo => commit[:repository][:name], :message => commit[:commit][:message]}}
    new_results
  end

  def self.find_following_events(user)
    new(user).find_following_events
  end

  def find_following_events
    results = get_url("/users/#{user}/following?client_id=#{ENV["GITHUB_CLIENT_ID"]}&client_secret=#{ENV["GITHUB_CLIENT_SECRET"]}")
    urls = []
    results.each {|result| urls << result[:events_url].split('{')[0]}
    new_results = []
    urls.each {|url| new_results << get_url(url + "?client_id=#{ENV["GITHUB_CLIENT_ID"]}&client_secret=#{ENV["GITHUB_CLIENT_SECRET"]}")}
    new_results
    newer_results = []
    new_results.each do |result|
      result.each do |new_result|
        newer_results << {:type => new_result[:type], :user => new_result[:actor][:login], :repo => new_result[:repo][:name].split('/')[-1], :date => new_result[:created_at].to_date}
      end
    end
    sorted_results = newer_results.sort_by {|hash| hash[:date]}
    sorted_results.reverse
  end

end
