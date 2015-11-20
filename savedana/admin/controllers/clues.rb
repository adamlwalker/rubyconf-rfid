Savedana::Admin.controllers :clues do
  get :index do
    @title = "Clues"
    @clues = Clues.all
    render 'clues/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'clues')
    @clues = Clues.new
    render 'clues/new'
  end

  post :create do
    @clues = Clues.new(params[:clues])
    if @clues.save
      @title = pat(:create_title, :model => "clues #{@clues.id}")
      flash[:success] = pat(:create_success, :model => 'Clues')
      params[:save_and_continue] ? redirect(url(:clues, :index)) : redirect(url(:clues, :edit, :id => @clues.id))
    else
      @title = pat(:create_title, :model => 'clues')
      flash.now[:error] = pat(:create_error, :model => 'clues')
      render 'clues/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "clues #{params[:id]}")
    @clues = Clues.find(params[:id])
    if @clues
      render 'clues/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'clues', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "clues #{params[:id]}")
    @clues = Clues.find(params[:id])
    if @clues
      if @clues.update_attributes(params[:clues])
        flash[:success] = pat(:update_success, :model => 'Clues', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:clues, :index)) :
          redirect(url(:clues, :edit, :id => @clues.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'clues')
        render 'clues/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'clues', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Clues"
    clues = Clues.find(params[:id])
    if clues
      if clues.destroy
        flash[:success] = pat(:delete_success, :model => 'Clues', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'clues')
      end
      redirect url(:clues, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'clues', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Clues"
    unless params[:clues_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'clues')
      redirect(url(:clues, :index))
    end
    ids = params[:clues_ids].split(',').map(&:strip)
    clues = Clues.find(ids)
    
    if Clues.destroy clues
    
      flash[:success] = pat(:destroy_many_success, :model => 'Clues', :ids => "#{ids.to_sentence}")
    end
    redirect url(:clues, :index)
  end
end
