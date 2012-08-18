require 'digest/md5'

puts Digest::MD5.hexdigest("jay123")
#=>f0e7d0d17cff891edbc9cdf92dcd9297

#method 1
puts Digest::MD5.hexdigest(File.read("class.rb"))
#=>136099e40c3588cb61680f81638aa384

#method 2
class Digest::MD5
  def self.open(path)
    o = self.new
    File.open(path) do |f|
      buf = ""
      while f.read(256, buf)
        o << buf
      end
    end
    o
  end
end
puts Digest::MD5.open("class.rb").hexdigest
#=>f1ae3c95d59070c4292edb89c204f5263bfbe1e3

require 'digest/sha1'

puts Digest::SHA1.hexdigest("jay123")
#=>613f9a889d27d04b42ef3423bce364b5729140a9

require 'uri'

puts URI.encode("jay123")
#=>Hello%20world
puts URI.decode("Hello%20world")
#=>Hello world

require 'base64'

puts Base64.encode64("jay123")
#=>SGVsbG8gd29ybGQ=
puts Base64.decode64("SGVsbG8gd29ybGQ=")
#=>Hello world

require 'securerandom'
puts SecureRandom.hex(123) 
puts SecureRandom.base64(123) 
puts SecureRandom.random_bytes(123)
 
require 'bcrypt'
#http://mike-gao.iteye.com/blog/894858
my_password = BCrypt::Password.create("jay123")
puts my_password.version
puts my_password.cost
puts my_password.hash
puts my_password.salt
pwd = BCrypt::Password.new("$2a$10$4B17N/sYGcT2UPsh1dOHXuJMX/TEYyoJ1h/twRLJ03.Vk5JjfoBN.")
puts pwd == "jay123"


class Des
  require 'openssl'
  require 'base64'
  ALG = 'DES-EDE3-CBC'
  KEY = "mZ4Wjs6L"
  DES_KEY = "nZ4wJs6L"

  #加密
  def encode(str)
    des = OpenSSL::Cipher::Cipher.new(ALG)
    des.pkcs5_keyivgen(KEY, DES_KEY)
    des.encrypt
    cipher = des.update(str)
    cipher << des.final
    return Base64.encode64(cipher) #Base64编码，才能保存到数据库
  end

  #解密  
  def decode(str)
    str = Base64.decode64(str)
    des = OpenSSL::Cipher::Cipher.new(ALG)
    des.pkcs5_keyivgen(KEY, DES_KEY)
    des.decrypt
    des.update(str) + des.final
  end
end
des = Des.new
# '=====encrypt====='
str = des.encode("jay123")
puts str
#=>cQZXSy4EdSV8mXVL37av0A==

#  '=====decrypt====='
str = des.decode("cQZXSy4EdSV8mXVL37av0A==")
puts str
#=>Hello world
