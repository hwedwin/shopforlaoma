Myblog::System.controllers :categories do
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
    @categories = Category.all
    render 'categories/index'
  end

  get :new do
    render 'categories/new'
  end

  post :create do
    @category = Category.new(params[:category])

    if @category.save
      redirect url(:categories, :index), note: "success"
    else
      redirect url(:categories, :new), note: "faild"
    end
  end

  get :edit do

  end

  post :update do

  end

end
