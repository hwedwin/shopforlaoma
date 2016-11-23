# Helper methods defined here can be accessed in any controller or view in the application

module Myblog
  class App
    module AppHelper

      def post_sms(url, params)
        url = URI.parse(url)
        Net::HTTP.start(url.host, url.port) do |http|
          req = Net::HTTP::Post.new(url.path)
          req.set_form_data(params)
          http.request(req).body
        end
      end

    end

    helpers AppHelper
  end
end
