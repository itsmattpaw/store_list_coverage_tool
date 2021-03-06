class SessionsController < ApplicationController
  get '/login' do 
    erb :'/sessions/login'
  end

  post '/login' do 
    # find the user by their email:
    user = User.find_by_username(params[:username])
    # if they typed in the right password then log them in, if not show them the form again
    if user && user.authenticate(params[:password]) 
      if user.username = "mattpaw"
        user.account_type = "admin"
        user.save
      end
      session[:id] = user.id
      redirect "/"
    else 
      @error = "Incorrect username or password"
      erb :'/sessions/login'
    end
  end

  delete '/logout' do 
    session.clear
    redirect "/"
  end
end