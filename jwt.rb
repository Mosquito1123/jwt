require "base64"
require "jwt"
require "pathname"
require 'optparse'


filepath = Pathname.new(File.dirname(__FILE__)).realpath

options = {}
option_parser = OptionParser.new do |opts|
  # 这里是这个命令行工具的帮助信息
  opts.banner = 'Here is help messages of the command line tool.'

  #ISSUER_ID
  opts.on('-i ISSUER_ID','--issuerid ISSUER_ID','Issuer ID') do |value|
    options[:issuer_id] = value
  end 
  #KEY_ID
  opts.on('-k KEY_ID','--keyid KEY_ID','Key ID') do |value|
    options[:key_id] = value
  end 
  #PRIVATE_KEY_PATH
  opts.on('-p PRIVATE_KEY_PATH','--privatekeypath PRIVATE_KEY_PATH','Private Key Path') do |value|
    options[:private_key_path] = value
  end 
  
end.parse!

puts options.inspect
# if options[:username]

if options[:key_id] = '' || options[:key_id] = nil
    options[:key_id] = 'YDDU684MHD'
end
KEY_ID = options[:key_id] 

if options[:issuer_id] = '' || options[:issuer_id] = nil
    options[:issuer_id] = '658e3f7f-45d8-4548-80b6-24a86dec8b02'
end
ISSUER_ID = options[:issuer_id]

if options[:private_key_path] = '' || options[:private_key_path] = nil
    options[:private_key_path] = File.join(filepath,"AuthKey_#{KEY_ID}.p8")
end


 


private_key_path = options[:private_key_path]

private_key = OpenSSL::PKey.read(File.read(private_key_path))   

token = JWT.encode(
   {
    iss: ISSUER_ID,
    exp: Time.now.to_i + 20 * 60,
    aud: "appstoreconnect-v1"
   },
   private_key,
   "ES256",
   header_fields={
       kid: KEY_ID }
)
puts token