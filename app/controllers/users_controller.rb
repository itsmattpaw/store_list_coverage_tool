class UsersController < ApplicationController 

  get '/users/new' do 
    erb :'users/new'
  end 

  post '/users' do 
    @user = User.new(username: params[:username], email: params[:email], password: params[:password], account_type: "standard")
    if @user.save
      session[:id] = @user.id
      redirect "/"
    else 
      erb :'users/new'
    end
  end
end