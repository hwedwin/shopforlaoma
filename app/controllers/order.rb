Myblog::App.controllers :order do

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

  get :intend_to_buy, :with => :id do
    @order = Order.new

    if current_user
      @seller = UserNode.find(session[:user_node]).seller
      @order.seller = @seller
      @order.user = current_user
      @order.amount = 0
      @order.status = "正在进行中"
      @order.customer_mobile = current_user.mobile
      @order.save
      @order_product = OrderProduct.new
      @order_product.product = Product.find(params[:id])
      @order_product.order = @order
      @order_product.counter = 1
      @order_product.save

    else
      session[:intend_to_buy] = true
      session[:product_id] = params[:id]
      redirect url('/login')
    end
    render 'order/show'

  end


end
