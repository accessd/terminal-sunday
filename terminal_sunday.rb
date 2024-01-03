#!/usr/bin/env ruby

require 'date'

if ARGV.length < 1
  puts "Usage: #{$0} birthdate [username]"
  puts "Example: #{$0} 1985-06-08 Joe"
  exit 1
end

birthdate = ARGV[0]
name = ARGV.length > 1 ? ARGV[1] : ENV['USER']
life_expectancy = 80

begin
  birthdate_parsed = Date.parse(birthdate)
rescue ArgumentError
  puts "Invalid date format. Please use YYYY-MM-DD."
  exit 1
end

current_date = Date.today
weeks_passed = (current_date - birthdate_parsed).to_i / 7
total_weeks = life_expectancy * 52
weeks_remaining = total_weeks - weeks_passed
birth_year = birthdate_parsed.year
years_passed = (current_date.year - birth_year)
last_year = birth_year + life_expectancy - 1

def red(str)
  "\e[41m#{str}\e[0m"
end
def green(str)
  "\e[42m#{str}\e[0m"
end

puts "#{name}, only #{weeks_remaining} Sundays remain\n"
puts "\n" if birth_year % 20 > 10

print "   " * ((birth_year - 1) % 20)
puts "#{birth_year}\n"
print "   " * ((birth_year - 1) % 20)

(0...life_expectancy).each do |year_index|
  year = birth_year + year_index
  if year_index < years_passed
    print red("  ")
  else
    print green("  ")
  end

  if year % 20 == 0 && year_index < life_expectancy-1
    puts
    puts
  else
    print " "
  end
end

indent = [0,((last_year % 20) * 3 - 5)].max
indent = 55 if last_year % 20 == 0
print "\n#{" " * indent}#{last_year}"

puts "\n\nHow are you going to spend these Sundays, #{name}?"
