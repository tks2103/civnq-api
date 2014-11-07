require 'net/http'

class AuthController < ApplicationController

  def steam
    #detect user
    steamid = User.strip_id(request.env['omniauth.auth']['uid'])
    user = User.find_or_create_by(steamid: steamid)
    #update metadata
    if user.username.nil?
      url = URI.parse("http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=#{ENV['STEAM_WEB_API_KEY']}&steamids=#{steamid}")
      req = Net::HTTP::Get.new(url.to_s)
      res = Net::HTTP.start(url.host, url.port) {|http|
          http.request(req)
      }
      user.username = JSON.parse(res.body)["response"]["players"][0]["personaname"]
      user.save!
    end

    #set session
    session[:steamid]   = steamid
    session[:username]  = user.username

    redirect_to "http://localhost:9000"
  end

end
