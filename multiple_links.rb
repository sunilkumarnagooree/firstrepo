require 'watir'
require 'pry'
$total_links = 0
$menu_links_arr = []
$file_links_arr = []

def collect_menu(browser)
  menu_links = browser.div(id: 'block-system-main-menu').links
  menu_links.each do |link|
    $menu_links_arr << link.href
  end
end

def goto_each_menu(browser)
  $menu_links_arr.each do |link|
    browser.goto link
    collect_table_count(browser)
  end
end

def collect_table_count(browser)
  tables = browser.div(class: 'primaryContent').tables
    tables.each do |table|
  collect_links_in_table(table)
end
end

def collect_links_in_table(table)
    links = table.links(href: /pdf/)
    $count = links.count
    collect_links(links)
    if table.next_sibling.link(text: 'Next').exists?
        until table.next_sibling.link(text: 'Next').attribute_value('class').include? 'disabled' do
             table.next_sibling.link(text: 'Next').click
            links = table.links(href: /pdf/)
            $count = $count + links.count
            collect_links(links)
    end
  end
  puts "==================="
  puts table
  puts "Table link count:  #{$count}"
  $total_links = $total_links + $count
  end


def collect_links(links)
  links.each do |link|
       $file_links_arr << [link.text,link.href]
   end
 end

browser = Watir::Browser.new :firefox
browser.goto 'http://www.iowamedicaidpdl.com/pa_forms'
collect_menu(browser)
goto_each_menu(browser)

puts "Menu count: #{$menu_links_arr.count}"
puts "Total link count : #{$total_links}"

browser.quit
