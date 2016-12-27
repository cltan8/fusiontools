require 'net/http'

class FusionsController < ApplicationController
  layout "fusions"
  @refreshtime = 360
  @@logger = Logger.new('logfile.log')
  @@hostnames = ["dev01.vm.tm0.com",
    "app.dev01.vm.tm0.com",
    "app.dev01.vm.tm0.com/cgi-bin/admin/become.cgi",
    "app2.dev01.vm.tm0.com",
    "app2.dev01.vm.tm0.com/cgi-bin/admin/become.cgi",
    "ebm.dev01.vm.tm0.com",
    "ttb.dev01.vm.tm0.com",
    "tt.dev01.vm.tm0.com",
    "webmail.dev01.vm.tm0.com",
    "qa26.vm.tm0.com",
    "app.qa26.vm.tm0.com",
    "app.qa26.vm.tm0.com/cgi-bin/admin/become.cgi",
    "ebm.qa26.vm.tm0.com",
    "webmail.qa26.vm.tm0.com",
    "ttb.qa26.vm.tm0.com",
    "tt.qa26.vm.tm0.com",
    ]
 
  def index
    #curl("dev01.vm.tm0.com")
    #curl("app.dev01.vm.tm0.com")
    #curl("app.dev01.vm.tm0.com/cgi-bin/admin/become.cgi")
    #curl("app2.dev01.vm.tm0.com")
    #curl("app2.dev01.vm.tm0.com/cgi-bin/admin/become.cgi")
    #curl("ebm.dev01.vm.tm0.com")
    #curl("ttb.dev01.vm.tm0.com")
    #curl("tt.dev01.vm.tm0.com")
    #curl("webmail.dev01.vm.tm0.com")
    #curl("qa26.vm.tm0.com")
    #curl("app.qa26.vm.tm0.com")
    #curl("app.qa26.vm.tm0.com/cgi-bin/admin/become.cgi")
    #curl("ebm.qa26.vm.tm0.com")
    #curl("webmail.qa26.vm.tm0.com")
    #curl("ttb.qa26.vm.tm0.com")
    #curl("tt.qa26.vm.tm0.com")
    curl2(@@hostnames)
    respond_to do |format|
      format.html
    end
  end

  private

    def curl2(hostnames)     
      hostnames.each do |hostname|        
        begin
          sleep 5
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
