SmartTrashCan::Admin.controllers :fridges do
 

  get :index do
    @title = "Fridges"
    @fridges = Fridge.all
    render 'fridges/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'fridge')
    @fridge = Fridge.new
    render 'fridges/new'
  end

  post :create do
    params[:fridge][:item] = "Updating..."
    params[:fridge][:rfid] = params[:fridge][:rfid].gsub!(/[^0-9A-Za-z]/, '')
     @fridge = Fridge.new(params[:fridge])
    if @fridge.save
      @title = pat(:create_title, :model => "fridge #{@fridge.id}")
      flash[:success] = pat(:create_success, :model => 'Fridge')
     SmartTrashCan::App.new.async.updateFridge(@fridge.id, params[:fridge][:barcode])
      params[:save_and_continue] ? redirect(url(:fridges, :new)) : redirect(url(:fridges, :new)) 
    else
      @title = pat(:create_title, :model => 'fridge')
      flash.now[:error] = pat(:create_error, :model => 'fridge')
      render 'fridges/new'
    end
  end

  get :edit, :with => :id do    
    @title = pat(:edit_title, :model => "fridge #{params[:id]}")
    @fridge = Fridge.find(params[:id])
    if @fridge
      render 'fridges/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'fridge', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "fridge #{params[:id]}")
    @fridge = Fridge.find(params[:id])
    if @fridge
      if @fridge.update_attributes(params[:fridge])
        flash[:success] = pat(:update_success, :model => 'Fridge', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:fridges, :index)) :
          redirect(url(:fridges, :edit, :id => @fridge.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'fridge')
        render 'fridges/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'fridge', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Fridges"
    fridge = Fridge.find(params[:id])
    if fridge
      if fridge.destroy
        flash[:success] = pat(:delete_success, :model => 'Fridge', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'fridge')
      end
      redirect url(:fridges, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'fridge', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Fridges"
    unless params[:fridge_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'fridge')
      redirect(url(:fridges, :index))
    end
    ids = params[:fridge_ids].split(',').map(&:strip)
    fridges = Fridge.find(ids)
    
    if Fridge.destroy fridges
    
      flash[:success] = pat(:destroy_many_success, :model => 'Fridges', :ids => "#{ids.to_sentence}")
    end
    redirect url(:fridges, :index)
  end
end
