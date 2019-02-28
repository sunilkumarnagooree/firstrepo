require_relative 'base'
require 'watir'
require 'pry'
class Prac < Base
  $file_url_list = []
  def go_to_url
    browser = firefox_browser
    browser.goto "https://info.caremark.com/medicapriorauthCMDLG#first"
    table = browser.div(id: 'content').table
    table.tbody.trs.each do |tr|
      tr.td
    binding.pry
    alph = ["D","I","P","S", "X"]
    alph.each do |a|
      puts "----------"
      puts a
      link = browser.div(id: 'content').link(text: a)
      puts link.text
      sleep 1
      link.click
    end
  end


end
obj = Prac.new
obj.go_to_url
