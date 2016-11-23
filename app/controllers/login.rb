Myblog::App.controllers :login do
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

  before :index do
    if current_user
      redirect url(:personal, :index)
    end
  end

  post :index do
    @user = {
      name: "username",
      pass: "cryptedpass",
      mobile: "18820965455"
    }
    set_current_user(@user)
    redirect url(:personal, :index)
  end

  get :index do

    render 'login/index'
  end

  get :out do
    destroy_current_user
    redirect url(:login, :index)
  end

  get :term do
    render 'login/term'
  end


  get :sms do
    sms_param = {
      "valid": '3443',
      "name": "Simon"
    }
    mobile = params[:mobile]

    post_sms('http://localhost:8080/sms.php',{
      sms_param: sms_param.to_json,
      rec_num: mobile
      });

    mobile.to_s


  end

end
