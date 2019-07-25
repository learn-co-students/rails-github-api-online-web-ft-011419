class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    response = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.body = { 'client_id': ENV['GITHUB_CLIENT_ID'], 'client_secret': ENV['GIHUB_SECRET'], code: params[:code]}
      req.headers['Accept'] = 'application/json'
  end

  body = JSON.parse(response.body)
  session[:token] = body["access_token"]
  user_response = Faraday.get("https://api.github.com/user") do |req|
    req.headers= { 'Accept': 'application/json', 'Authorization': "token #{session[:token]}" }
  end

  user_body = JSON.parse(user_response.body)
  session[:username] = user_body["login"]
  redirect_to root_path
  end
end
