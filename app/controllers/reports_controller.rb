class ReportsController < ApplicationController

  # GET: /reports -> index
  get "/reports" do
    @reports = Report.all
    erb :"/reports/index.html"
  end

  # GET: /reports/new -> new
  get "/reports/new" do
    redirect_if_not_logged_in
    @report = Report.new
    erb :"/reports/new.html"
  end

  # POST: /reports -> create
  post "/reports" do
    redirect_if_not_logged_in
    @report = current_user.reports.build(title: params[:report][:title])
    if @report.save
      redirect "/reports"
    else
      erb :"/reports/new.html"
    end
  end

  # GET: /reports/5 -> show
  get "/reports/:id" do
    set_report
    erb :"/reports/show.html"
  end

  # GET: /posts/5/edit -> edit
  get "/reports/:id/edit" do
    set_report
    redirect_if_not_authorized
    erb :"/reports/edit.html"
  end

  # PATCH: /reports/5 -> update
  patch "/reports/:id" do
    set_report
    redirect_if_not_authorized
    if @report.update(title: params[:report][:title])
      flash[:success] = "Report successfully updated"
      redirect "/reports/#{@report.id}"
    else 
      erb :"/reports/edit.html"
    end
  end

  # DELETE: /reports/5 - destroy
  delete "/reports/:id" do
    set_report
    redirect_if_not_authorized
    @report.destroy
    redirect "/reports"
  end

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
      end
    end
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
