class RepositoriesController < ApplicationController
  
  def index
      @res = Faraday.get("https://api.github.com/user/repos") do |req|
     req.headers = { 'Accept': 'application/json', 'Authorization': "token #{session[:token]}" }
    end
   @repos= JSON.parse(@res.body)
  end

end
