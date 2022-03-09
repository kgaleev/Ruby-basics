print a = "Side a of triangle value? "
a = Integer(gets.chomp)
print b = "Side b of triangle value? "
b = Integer(gets.chomp)
print c = "Side b of triangle value? "
c = Integer(gets.chomp)
if a ** 2 + b ** 2 == c ** 2 || b ** 2 + c ** 2 == a ** 2 || a ** 2 + c ** 2 == b ** 2
  puts "bingo"
elsif a == b && b == c
  puts "equilateral triangle"
elsif (a == b && c != b) || (b == c && a != c) || (a == c && b != c)
  puts "isosceles triangle"
elsif
  puts "(╯°□ °)╯︵ ┻━┻"
end
