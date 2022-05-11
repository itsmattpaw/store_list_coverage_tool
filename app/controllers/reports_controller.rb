class ReportsController < ApplicationController

  get "/company/test" do
    @company = Company.all.first
    #binding.pry
    erb :"reports/slvc/slvc"
  end

  get '/slvc/new' do
    redirect_if_not_logged_in
    erb :"reports/slvc/new-slvc"
  end

  post '/slvc/new' do
    @user = current_user
    @company = Company.find_by(name: params[:company])
    @compgeo = {}
    @company.stores.all.each do |st|
      #binding.pry
      if st.slvcdata
        if @compgeo.include?(st.slvcdata.company.strip.to_sym)
          @compgeo[st.slvcdata.company.strip.to_sym] += 1
        else  
          @compgeo[st.slvcdata.company.strip.to_sym] = 1
        end
      else  
        @compgeo[:blank] += 1
      end
    end
    erb :'reports/slvc/slvc'
  end

  post '/slvc/download' do
    @company = params[:company]
    @compgeo = params[:compgeo]
    erb :'reports/slvc/slvc'
  end

  private 

  def set_report
    @report = Report.find_by_id(params[:id])
    if @report.nil?
      flash[:error] = "Couldn't find a Report with id: #{params[:id]}"
      redirect "/reports"
    end
  end

  def redirect_if_not_authorized
    redirect_if_not_logged_in
    if !authorize_report(@report)
      flash[:error] = "You don't have permission to do that action"
      redirect "/reports"
    end
  end

  def authorize_report(report)
    current_user == report.user
  end

end
