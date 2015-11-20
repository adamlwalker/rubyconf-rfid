Fashionista::Admin.controllers :clothings do
  get :index do
    @title = "Clothings"
    @clothings = Clothing.all
    render 'clothings/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'clothing')
    @clothing = Clothing.new
    render 'clothings/new'
  end

  post :create do
    @clothing = Clothing.new(params[:clothing])
    if @clothing.save
      @title = pat(:create_title, :model => "clothing #{@clothing.id}")
      flash[:success] = pat(:create_success, :model => 'Clothing')
      params[:save_and_continue] ? redirect(url(:clothings, :index)) : redirect(url(:clothings, :edit, :id => @clothing.id))
    else
      @title = pat(:create_title, :model => 'clothing')
      flash.now[:error] = pat(:create_error, :model => 'clothing')
      render 'clothings/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "clothing #{params[:id]}")
    @clothing = Clothing.find(params[:id])
    if @clothing
      render 'clothings/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'clothing', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "clothing #{params[:id]}")
    @clothing = Clothing.find(params[:id])
    if @clothing
      if @clothing.update_attributes(params[:clothing])
        flash[:success] = pat(:update_success, :model => 'Clothing', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:clothings, :index)) :
          redirect(url(:clothings, :edit, :id => @clothing.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'clothing')
        render 'clothings/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'clothing', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Clothings"
    clothing = Clothing.find(params[:id])
    if clothing
      if clothing.destroy
        flash[:success] = pat(:delete_success, :model => 'Clothing', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'clothing')
      end
      redirect url(:clothings, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'clothing', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Clothings"
    unless params[:clothing_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'clothing')
      redirect(url(:clothings, :index))
    end
    ids = params[:clothing_ids].split(',').map(&:strip)
    clothings = Clothing.find(ids)
    
    if Clothing.destroy clothings
    
      flash[:success] = pat(:destroy_many_success, :model => 'Clothings', :ids => "#{ids.to_sentence}")
    end
    redirect url(:clothings, :index)
  end
end
