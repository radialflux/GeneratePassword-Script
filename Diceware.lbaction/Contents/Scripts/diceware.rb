#!/usr/bin/env ruby

dice_file = '../Resources/diceware.wordlist.asc'

def pbcopy(input)
  str = input.to_s
  IO.popen('pbcopy', 'w') { |f| f << str }
  str
end

SYMBOLS = [%w[1 ~ ! # $ % ^],
           %w[2 & * ( ) - =],
           %w[3 + [ ] \ { }],
           %w[4 : ; " ' < >],
           %w[5 ? / 0 1 2 3],
           %w[6 4 5 6 7 8 9]]

alphanumeric = false

count = ARGV[0] || 6
separators = [' '] * (count.to_i - 1)

words = {}
f = File.open(dice_file, "r")
f.each_line do |line|
  next unless (line =~ /^\d\d\d\d\d/)
  key,word = line.split
  words[key] = word
end

passwords = count.to_i.times.map do
  roll = (0..4).map{ 1 + rand(6) }.join
  words[roll]
end

puts pbcopy passwords.zip(separators).flatten.join
