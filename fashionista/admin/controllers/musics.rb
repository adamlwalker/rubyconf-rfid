Fashionista::Admin.controllers :musics do
  get :index do
    @title = "Musics"
    @musics = Music.all
    render 'musics/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'music')
    @music = Music.new
    render 'musics/new'
  end

  post :create do
    @music = Music.new(params[:music])
    if @music.save
      @title = pat(:create_title, :model => "music #{@music.id}")
      flash[:success] = pat(:create_success, :model => 'Music')
      params[:save_and_continue] ? redirect(url(:musics, :index)) : redirect(url(:musics, :edit, :id => @music.id))
    else
      @title = pat(:create_title, :model => 'music')
      flash.now[:error] = pat(:create_error, :model => 'music')
      render 'musics/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "music #{params[:id]}")
    @music = Music.find(params[:id])
    if @music
      render 'musics/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'music', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "music #{params[:id]}")
    @music = Music.find(params[:id])
    if @music
      if @music.update_attributes(params[:music])
        flash[:success] = pat(:update_success, :model => 'Music', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:musics, :index)) :
          redirect(url(:musics, :edit, :id => @music.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'music')
        render 'musics/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'music', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Musics"
    music = Music.find(params[:id])
    if music
      if music.destroy
        flash[:success] = pat(:delete_success, :model => 'Music', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'music')
      end
      redirect url(:musics, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'music', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Musics"
    unless params[:music_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'music')
      redirect(url(:musics, :index))
    end
    ids = params[:music_ids].split(',').map(&:strip)
    musics = Music.find(ids)
    
    if Music.destroy musics
    
      flash[:success] = pat(:destroy_many_success, :model => 'Musics', :ids => "#{ids.to_sentence}")
    end
    redirect url(:musics, :index)
  end
end
