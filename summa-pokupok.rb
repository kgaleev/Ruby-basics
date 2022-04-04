
=begin
nazvanie
cena
kolichestvo (float)

poka nazvanie ne "стоп", vvodit luboe kolichestvo tovarov

nujen hash {'nazvanie' => {cena => kolichestvo}} - vlojenniy hash
puts itogovaya summa za kajdiy tovar
puts summa vseh pokupok
=end

h = Hash.new
#h1 = Hash.new
#h2 = Hash.new
items = items.to_s

loop do

puts "Введите название товара "
items = gets.chomp

  if items == "stop"
    break

  else
    puts "Введите цену товара "
    price = gets.chomp.to_f

    puts "Введите количество товара "
    amount = gets.chomp.to_f

    if h[items] == nil
      h[items] = {price => amount}
    else
      h[items] = h[items].merge!(price => amount)
    end

    #h1[items] = price
    #h2[items = amount

  end

end

#h = h.values.to_a

puts h
#puts h1
#puts h2

#h1.each do |item, pric|
#  puts pric * h2[items]
#end

korzina = 0.0

h.each do |item, ihash|

  ihash.each do |p, q|
  itog = p * q
  korzina = korzina + itog
  puts "#{item}: #{itog}"
  end

=begin
  ihash = ihash.to_a
  itog = ihash[0][0] * ihash[0][1]
  puts "#{item}: #{itog}"
  korzina = korzina + itog
=end

end
puts "summa: #{korzina}"

  #ihash = ihash.to_a[0]
#  puts sum[itog]

  #puts sum = ihash[0] * ihash[1]
#end


#h.each_pair {|key, value| puts "#{value}"}
#h[item].each {|}

#h.each_pair {|key, value| puts "#{key}: #{value}"}
