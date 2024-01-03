#!/usr/bin/env ruby

require 'date'

if ARGV.length < 1
  puts "Usage: #{$0} birthdate [username]"
  puts "Example: #{$0} 1985-06-08 Joe"
  exit 1
end

birthdate = ARGV[0]
name = ARGV.length > 1 ? ARGV[1] : ENV['USER']

LIFE_EXPECTANCY = [
  # Via Statistics Canada https://www150.statcan.gc.ca/t1/tbl1/en/tv.action?pid=1310013401
  [25, 80.2],
  [30, 80.4],
  [35, 80.6],
  [40, 80.8],
  [45, 81.1],
  [50, 81.5],
  [55, 82.0],
  [60, 82.8],
  [65, 83.8],
  [70, 85.2],
  [75, 86.9],
  [80, 89.1],
  [85, 91.8],
  [90, 95.1]
]
def life_expectancy_at(age_in_years)
  # Short-circuit outside census range
  return 80 if age_in_years < 25
  return age_in_years + 5 if age_in_years >= 90

  # Otherwise linearly interpolate between steps
  i = LIFE_EXPECTANCY.index { |age, expect| age <= age_in_years }
  baseline = LIFE_EXPECTANCY[i][1]
  step_progress = (age_in_years - LIFE_EXPECTANCY[i][0]) / 5.0
  step_change = LIFE_EXPECTANCY[i+1][1] - LIFE_EXPECTANCY[i][1]
  baseline + step_change * step_progress
end

begin
  birthdate_parsed = Date.parse(birthdate)
rescue ArgumentError
  puts "Invalid date format. Please use YYYY-MM-DD."
  exit 1
end

current_date = Date.today
weeks_passed = (current_date - birthdate_parsed).to_i / 7
years_passed = weeks_passed / 52
life_expectancy = life_expectancy_at(years_passed)
total_weeks = life_expectancy * 52
weeks_remaining = (total_weeks - weeks_passed).to_i
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
print " " * 55 + last_year.to_i.to_s

puts "\n\nHow are you going to spend these Sundays, #{name}?"
