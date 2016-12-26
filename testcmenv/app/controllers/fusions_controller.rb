require 'net/http'

class FusionsController < ApplicationController
  layout "fusions"
  @@logger = Logger.new('logfile.log')
 
  def index
    curl("dev01.vm.tm0.com")
    curl("app.dev01.vm.tm0.com")
    curl("app.dev01.vm.tm0.com/cgi-bin/admin/become.cgi")
    curl("app2.dev01.vm.tm0.com")
    curl("app2.dev01.vm.tm0.com/cgi-bin/admin/become.cgi")
    curl("ebm.dev01.vm.tm0.com")
    curl("webmail.dev01.vm.tm0.com")
    curl("qa26.vm.tm0.com")
    curl("app.qa26.vm.tm0.com")
    curl("app.qa26.vm.tm0.com/cgi-bin/admin/become.cgi")
    curl("ebm.qa26.vm.tm0.com")
    curl("webmail.qa26.vm.tm0.com")
    respond_to do |format|
      format.html
    end
  end

  private

    def curl(hostname)
      sleep 5
      begin
        uri = URI.parse("https://"+hostname)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        request = Net::HTTP::Get.new(uri.request_uri)
        response = http.request(request)
        content = response.body.gsub("\n", "").squeeze()
        if response.code == 200
          @@logger.debug("success:#{hostname}:#{content}");
        else
          @@logger.debug("#{response.code}:#{hostname}:#{content}");
        end
        puts response.body
      rescue Exception => e
        @@logger.debug("error:#{hostname}:#{e.message}");
      end
    end
end
