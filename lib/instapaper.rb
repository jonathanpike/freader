require 'net/http'

# Thank you to http://danknox.github.io/2013/01/27/using-rubys-native-nethttp-library/

class Instapaper
  def initialize(username, password)
    @username = username
    @password = password
    uri = URI("https://www.instapaper.com/")
    @http = Net::HTTP.new(uri.host, uri.port)
    @http.use_ssl = true  
  end 
  
  def authenticate
    res = http_request("/api/authenticate")

    return true if res.code == "200"
    false
  end
  
  def add(url)
    res = http_request("/api/add", { url: url })
    return true if res.code == "201"
    false
  end 
  
  private 
  
  def http_request(path, params = {})
    if params.empty?
      req = Net::HTTP::Get.new(path)
    else 
      full_path = encode_path_params(path, params)
      req = Net::HTTP::Get.new(full_path)
    end 
    req.basic_auth @username, @password
    
    @http.request(req)
  end 
  
  def encode_path_params(path, params)
    encoded = URI.encode_www_form(params)
    [path, encoded].join("?")
  end
end 