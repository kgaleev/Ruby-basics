arr1 = ('a'..'z').to_a
#puts arr1.count
#arr1.map { |x| x.to_sym }
arr2 = (1..26).to_a
#arr2.map { |y| y.to_sym }
#puts arr1.to_s
#puts arr2.to_s
hash = arr1.zip(arr2).to_h
hash.keep_if { |key, value| key.start_with?(/[aeiou]/) }
puts hash
#h1 = hash.invert
#puts h1
#hash.each do |a, b|
#  if arr3[a] == "a" || 'e' || 'i' || 'o' || 'u' || 'y'
#
#end
#arr3.each.delete_if {|arr1, arr2| arr1 != "a" || 'e' || 'i' || 'o' || 'u' || 'y'}
#hash.each do |i => b|
#puts "#{arr3}"
#end
