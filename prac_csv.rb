require 'csv'
top250_arr = []
CSV.foreach("/Users/sunilkumar/Downloads/top250.csv",headers: false) do |row|
  top250_arr << row
end
puts top250_arr.count

change_list_arr = []
CSV.foreach("/Users/sunilkumar/Downloads/change_list.csv",headers: false) do |row|
  change_list_arr << row
end
puts change_list_arr.count

puts change_list_arr - top250_arr
