Myblog::System.controllers :pictures do
  layout :app
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
  #   "Maps to url '/foo/#{params[:id]}'"
  # end

  # get '/example' do
  #   'Hello world!'
  # end

  get :index do
    @pictures = Picture.all
    render 'pictures/index'
  end

  get :new do

    render 'pictures/new'
  end

  get :edit do

  end

  get :onepicture do
    Picture.all.to_json
  end

  post :create do
    @picture = Picture.new(params[:picture]);
    if @picture.save
      redirect url(:pictures, :index)
    else
      redirect url(:pictures, :new)
    end
  end

  post :update do

  end

end
