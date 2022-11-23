# atcoder practice 1

def chk_range(n)
  if n < 1 || n > 1000
    raise StandardError, "over of the range: #{n}"
  end
end

a = STDIN.gets.chomp
b0 = STDIN.gets.chomp
s = STDIN.gets.chomp

begin
  a = a.to_i
  chk_range(a)
rescue StandardError => e
  raise e
end

b = 0
c = 0
begin
  b0 = b0.split
  b = b0[0].to_i
  c = b0[1].to_i
  chk_range(b)
  chk_range(c)
rescue StandardError => e
  raise e
end

if s.size > 100
  raise StandardError, "s's size is over."
end

puts "#{a + b + c} #{s}"

#---
