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

puts "#{name}, only #{weeks_remaining} Sundays remain\n\n"

(0...life_expectancy).each do |year_index|
  puts "#{birth_year}\n" if year_index == 0
  print year_index < years_passed ? "\e[41m  \e[0m " : "\e[42m  \e[0m "

  line_break = (year_index == life_expectancy - 1) ? "\n" : "\n\n"
  print line_break if (year_index + 1) % 20 == 0
end
print " " * 55 + last_year.to_s

puts "\n\nHow are you going to spend these Sundays, #{name}?"
