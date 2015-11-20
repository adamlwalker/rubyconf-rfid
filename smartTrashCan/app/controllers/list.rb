SmartTrashCan::App.controllers :list do
  
  get :index, :map => '/' do
    @items = Fridge.where(onhand: false)
    render "list/index"

    
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
