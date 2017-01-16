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
    "ttb.dev01.vm.tm0.com/browse",
    "tt.dev01.vm.tm0.com/ttview",
    "webmail.dev01.vm.tm0.com",
    "qa26.vm.tm0.com",
    "app.qa26.vm.tm0.com",
    "app.qa26.vm.tm0.com/cgi-bin/admin/become.cgi",
    "ebm.qa26.vm.tm0.com",
    "webmail.qa26.vm.tm0.com",
    "ttb.qa26.vm.tm0.com/browse",
    "tt.qa26.vm.tm0.com/ttview",
    ]
  @@stagehostnames = [
    "app.staging.cheetahmail.com/cgi-bin/admin/become.cgi",
    "app.staging.cheetahmail.com",
    "ebm.staging.cheetahmail.com",
    "ttb.staging.cheetahmail.com/browse",
    "tt01.staging.cheetahmail.com/ttview",
    "webmail.staging.cheetahmail.com"
  ]
  
  @@proxyservers = [
    "proxy.staging.cheetahmail.com",
    "443"
  ]

  @@testhostnames = [
    "app.dev01.vm.tm0.com",
    "qa26.vm.tm0.com"
  ]

  def index
    @res = []
    curl3(@@hostnames, nil, @res)
    respond_to do |format|
      format.html
    end
    @res2 = []
    curl3(@@stagehostnames, @@proxyservers, @res2)
    respond_to do |format|
      format.html
    end
    @nexturl = "http://localhost:3000/fusions"
  end

  def test
    @res = []
    curl3(@@testhostnames, nil, @res)
    respond_to do |format|
      format.html
    end
  end

  private

    def curl3(hostnames, proxyservers=nil, res=nil)
      res.clear
      hostnames.each do |hostname|
        begin
          sleep 5
          uri = URI.parse("https://"+hostname)
          if proxyservers.nil?
            http = Net::HTTP.new(uri.host, uri.port)
          else
            http = Net::HTTP.new(uri.host, uri.port, @@proxyservers[0], @@proxyservers[1])
          end
          http.use_ssl = true
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE
          request = Net::HTTP::Get.new(uri.request_uri)
          response = http.request(request)
          content = response.body.gsub("\n", "").squeeze()
          if response.code == 200
            res.push "200:#{hostname}"
            @@logger.debug("success:#{hostname}:#{content}");
          else
            res.push "#{response.code}:#{hostname}"
            @@logger.debug("#{response.code}:#{hostname}:#{content}");
          end
          puts response.body
        rescue Exception => e
          res.push "999:#{hostname}"
          @@logger.debug("error:#{hostname}:#{e.message}");
        end
      end
    end

    def curl2(hostnames, proxyservers=nil)
      hostnames.each do |hostname|
        begin
          sleep 5
          uri = URI.parse("https://"+hostname)
          if proxyservers.nil?
            http = Net::HTTP.new(uri.host, uri.port)
          else
            http = Net::HTTP.new(uri.host, uri.port, @@proxyservers[0], @@proxyservers[1])
          end
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
