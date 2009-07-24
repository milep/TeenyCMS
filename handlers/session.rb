post '/unauthenticated/?' do
  show_header
  show_menu
  status 401
  erb :login
end

get '/login/?' do
  show_header
  show_menu
  erb :login
end

post '/login/?' do
  env['warden'].authenticate!
  redirect "/admin"
end

get '/logout/?' do
  env['warden'].logout
  redirect '/login'
end
