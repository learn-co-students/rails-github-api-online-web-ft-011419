class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    resp = Faraday.post('https://github.com/login/oauth/access_token') do |req|
      req.body = { 'client_id': ENV['GITHUB_CLIENT_ID'], 'client_secret': ENV['GITHUB_CLIENT_SECRET'], 'code': params['code'] }
      req.headers['Accept'] = 'application/json'
    end

    body = JSON.parse(resp.body)
    session[:token] = body['access_token']

    user_response = Faraday.get('https://api.github.com/user') do |req|
      req.params['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end

    user_json = JSON.parse(user_response.body)
    session[:username] = user_json['login']

    redirect_to root_path
  end

  # def create
  #   response = Faraday.post 'https://github.com/login/oauth/access_token', { client_id: '7b7fcd1ccc5eb1003a85', client_secret: '164edef9f97fe23ba7eb95817bf0cff1a854016e', code: params[:code] }, 'Accept' => 'application/json'
  #   access_hash = JSON.parse(response.body)
  #   session[:token] = access_hash['access_token']

  #   user_response = Faraday.get 'https://api.github.com/user', {}, 'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'
  #   user_json = JSON.parse(user_response.body)
  #   session[:username] = user_json['login']

  #   redirect_to '/'
  # end
end
