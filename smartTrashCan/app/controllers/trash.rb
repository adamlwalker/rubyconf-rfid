SmartTrashCan::App.controllers :trash do
  
  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

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
  
  post :create, :map => '/trash', :csrf_protection => false do
   params.map{|k,v| @arr = k.split(',')}
   item = Fridge.where(barcode: @arr[1]).first
   item.update(onhand: false)
  end

  get :index do


  end

end
