class RepositoriesController < ApplicationController
  
  def index
    @repo_resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.params['oauth_token'] = session[:token]
    end
    @repo = JSON.parse(@repo_resp.body)
  end

end
