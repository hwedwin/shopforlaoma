module Myblog
  class System < Padrino::Application
    register Padrino::Mailer
    register Padrino::Helpers
    enable :sessions
    layout :app

    get '/' do
      render 'index'
    end


    # get '/deletenodes' do
    #   tt = ShareNode.all
    #   tt.to_json
    # end
    # get '/share_node' do
    #   node = ShareNode.new
    #   node.is_root = 1
    #   node.save
    #   node.to_json
    # end
    #
    # get '/allshare' do
    #   ShareNode.all.to_json
    # end
    #
    # get 'newbill' do
    #
    # end

    get 'nodes' do
      root = UserNode.new
      child_one = root.child_user_nodes.build
      child_one.save
      child_two = root.child_user_nodes.build
      child_two.save
      root.save
      root.to_json

    end

    get 'deletenodes' do
      UserNode.all.to_json
    end

    get 'allnodes' do
      # UserNode.find("58367deeb85af163102da139")
      UserNode.all.to_json
    end


    get :testrole do
      @role = Role.new
      @role.name = "afewaef"

      @role.access_controllers=[{
        access_name: 'post',
        readable: true,
        updatable: true
        },{

        }
      ]
      @role.save
      @role.access_controllers.to_json
    end

    ##
    # Caching support.
    #
    # register Padrino::Cache
    # enable :caching
    #
    # You can customize caching store engines:
    #
    # set :cache, Padrino::Cache.new(:LRUHash) # Keeps cached values in memory
    # set :cache, Padrino::Cache.new(:Memcached) # Uses default server at localhost
    # set :cache, Padrino::Cache.new(:Memcached, :server => '127.0.0.1:11211', :exception_retry_limit => 1)
    # set :cache, Padrino::Cache.new(:Memcached, :backend => memcached_or_dalli_instance)
    # set :cache, Padrino::Cache.new(:Redis) # Uses default server at localhost
    # set :cache, Padrino::Cache.new(:Redis, :host => '127.0.0.1', :port => 6379, :db => 0)
    # set :cache, Padrino::Cache.new(:Redis, :backend => redis_instance)
    # set :cache, Padrino::Cache.new(:Mongo) # Uses default server at localhost
    # set :cache, Padrino::Cache.new(:Mongo, :backend => mongo_client_instance)
    # set :cache, Padrino::Cache.new(:File, :dir => Padrino.root('tmp', app_name.to_s, 'cache')) # default choice
    #

    ##
    # Application configuration options.
    #
    # set :raise_errors, true       # Raise exceptions (will stop application) (default for test)
    # set :dump_errors, true        # Exception backtraces are written to STDERR (default for production/development)
    # set :show_exceptions, true    # Shows a stack trace in browser (default for development)
    # set :logging, true            # Logging in STDOUT for development and file for production (default only for development)
    # set :public_folder, 'foo/bar' # Location for static assets (default root/public)
    # set :reload, false            # Reload application files (default in development)
    # set :default_builder, 'foo'   # Set a custom form builder (default 'StandardFormBuilder')
    # set :locale_path, 'bar'       # Set path for I18n translations (default your_apps_root_path/locale)
    # disable :sessions             # Disabled sessions by default (enable if needed)
    # disable :flash                # Disables sinatra-flash (enabled by default if Sinatra::Flash is defined)
    # layout  :my_layout            # Layout can be in views/layouts/foo.ext or views/foo.ext (default :application)
    #

    ##
    # You can configure for a specified environment like:
    #
    #   configure :development do
    #     set :foo, :bar
    #     disable :asset_stamp # no asset timestamping for dev
    #   end
    #

    ##
    # You can manage errors like:
    #
    #   error 404 do
    #     render 'errors/404'
    #   end
    #
    #   error 500 do
    #     render 'errors/500'
    #   end
    #
  end
end
