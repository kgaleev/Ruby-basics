print a = "From equation a*x^2 + b*x + c = 0 enter coefficient a = "
a = Float(gets.chomp)
print b = "From equation a*x^2 + b*x + c = 0 enter coefficient b = "
b = Float(gets.chomp)
print c = "From equation a*x^2 + b*x + c = 0 enter coefficient c = "
c = Float(gets.chomp)
d = (b**2 - 4*a*c)
if d < 0
  puts "d = #{d}"
  puts "Корней нет"
elsif d > 0
  e = Math.sqrt(d)
  puts "d = #{d}"
  puts x1 = (-b + e) / (2*a)
  puts x2 = (-b - e) / (2*a)
elsif d == 0
  e = Math.sqrt(d)
  puts "d = #{d}"
  puts x = (-b + e) / (2*a)
end
