arr = [0, 1]
#arr.push[0] = 0
#arr.push[1] = 1
i = 1
# until arr.max >= 100 do
until arr[-2]+arr[-1] >= 100 do
  i = i + 1
  arr.push( arr[i-1] + arr[i-2] )
end
#arr.delete_at(-1)
puts arr.to_s
