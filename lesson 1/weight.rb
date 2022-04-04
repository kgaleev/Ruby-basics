print name = "What is your name? "
name = gets.chomp
name.capitalize!
print height = "What is your height? "
height = Integer(gets.chomp)
weight = ((height - 110) * 1.15).round
if weight >= 0
  puts "#{name}, your ideal weight is #{weight}"
else
  puts "Ваш вес уже оптимальный"
end
