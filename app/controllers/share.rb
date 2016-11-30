Myblog::App.controllers :share do

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

  get :index, :with => :id do

    if params[:id].nil?
      redirect url(:login, :index)
    end
    session[:user_node] = params[:id]
    @fuser_node = UserNode.find(session[:user_node])
    if current_user
      if @fuser_node.user == User.find(current_user.id)
        return session[:user_node] = params[:id]

      else
        if current_user.user_node
          return session[:user_node] = current_user.user_node.id
        else
          @new_user_node = UserNode.new
          @new_user_node.seller = @fuser_node.seller
          @new_user_node.fuser_node = @fuser_node.id
          @new_user_node.user_node = @fuser_node
          @new_user_node.save
          session[:user_node] = @new_user_node.id
          return session[:user_node]

        end

      end
    else
      redirect url(:login, :index)
    end

  end


end
