require 'bcrypt'
#http://mike-gao.iteye.com/blog/894858
puts BCrypt::Password.create("jay123")
pwd = BCrypt::Password.new("$2a$10$pzK09tmabTF2WVk.EuMztuxCA87ep98HnVfCkVDSaaWiy8g.bLURi")
a1 = %w(a b c d e f g h i j k l m n o p q r s t u v w x y z 0 1 2 3 4 5 6 7 8 9)

b1 = Array.new
a1.each do |a|
  b1.push(a) if pwd.include?(a)
end

b2 = Array.new
a1.each do |a|
  b1.each do |b|
    c = "#{a}#{b}"
    b2.push(c) if pwd.include?(c)
    c = "#{b}#{a}"
    b2.push(c) if pwd.include?(c)
  end
end

puts b2.inspect


