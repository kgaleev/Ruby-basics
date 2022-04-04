
# chislo 1-31
puts "Введите день (1-31) "
d = gets.chomp.to_i
until d <= 31 && d >= 1
  puts "Введите день (1-31)! "
  d = gets.chomp.to_i
  end

# mesyac 1-12
puts "Введите месяц (1-12) "
m = gets.chomp.to_i
until m <= 12 && m >= 1
  puts "Введите месяц (1-12)! "
  m = gets.chomp.to_i
end

#month array
m1 = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30]

puts "Введите год (1582+) "
y = gets.chomp.to_i
until y >= 1582
  puts "Введите год! (1582+) "
  y = gets.chomp.to_i
end

m2 = m1[0..m - 1].sum

if m >= 3
  if ( y % 4 == 0 && y % 100 > 0 ) || y % 400 == 0
#    if y.to_i % 100 == 0 && y.to_i % 400 == 0
#     puts "visokosniy"
      puts d + m2 + 1
#    else
#      puts d.to_i + m2
#    end
#  elsif y.to_i % 4 == 0 && y.to_i % 400 > 0
#    puts d.to_i + m2 + 1
  else
    puts d + m2
  end
else
  puts d + m2
end

#    puts d.to_i + m1[m.to_i-1] + 1
#  end
#end
#if m1[m.to_i - 1] >= 28
#  puts "hi"
#end

#if y.to_i % 4 == 0 && y.to_i % 100 == 0 && y.to_i % 400 == 0
#if god visokosniy, formula takaya
#else formula-1


#puts "#{d}.#{m}.#{y}"
# puts "#{d.to_i}.#{m.to_i}.#{y.to_i}"

# god any (visokosniy ili net) if /4 bez ostatka to proverka
# esli /100 i /400 - true, esli tolko /100 - false
