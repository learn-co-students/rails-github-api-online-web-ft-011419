class RepositoriesController < ApplicationController
  def index
    response = Faraday.get 'https://api.github.com/user/repos', {}, 'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'
    @repos = JSON.parse(response.body)

    user_response = Faraday.get('https://api.github.com/user') do |req|
      req.params['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end

    user_json = JSON.parse(user_response.body)
    session[:username] = user_json['login']
  end
end
