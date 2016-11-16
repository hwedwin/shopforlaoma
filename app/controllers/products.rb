Myblog::App.controllers :products do

  layout :homepage

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
    @products = 'active'
    render 'products/index'
  end

  get :index, :with => :id do
    @products = 'active'
    render 'products/product'
  end

  get :insurance do

  end

  get :insurance, :with => :id do
    @products = 'active'
    '保险'
  end

  get :car do

  end

  get :car_using do

  end

end
