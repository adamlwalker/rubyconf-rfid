Savedana::App.controllers :clues do
     set :protection, false
  set :protect_from_csrf, false
  set :allow_disabled_csrf, true
  
  get :index, :map => '/' do
   # session[:foo] = 'bar'
    render 'index'
  end

  post :check, :map => '/update', :csrf_protection => false do
    @findclue = Clues.find_by(rfid: params[:tag])
    if @findclue
     @found = true
     render 'index'
    else 
      @findclue = 'none'
      @message = 'Sorry Coraline, try again'
      render 'index'
    end 
  end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   'Maps to url '/foo/#{params[:id]}''
  # end

  # get '/example' do
  #   'Hello world!'
  # end
  

end
