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

  get '/admin' do
    redirect_if_not_logged_in
    if admin?
      @user = current_user
      erb :"users/admin"
    else
      redirect '/'
    end
  end

  post '/admin/slvc' do
    SlvcGenerator.slvc_data_update("./slvc_all_5_3_22.csv")
    @message = "success"
    @user = current_user
    erb :'users/admin'
  end

  post '/admin/biz-list' do
    SlvcGenerator.business_list_update("./100k_business_list.csv")
    @message = "success"
    @user = current_user
    erb :"users/admin"
  end

end