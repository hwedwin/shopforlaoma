Myblog::System.controllers :orders do

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
    @orders = Order.all
    render 'orders/index'
  end

  get :change_state, :with => :id do
    @order = Order.find(params[:id])
    @order.status = params[:state]
    if @order.update
      @order.status
    else
      0
    end
  end

  get :change_settlement_money do

  end

end
