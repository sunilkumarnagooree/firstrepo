require_relative 'base'
require 'pry'
class Test1 < Base
  @@file_url_list = []
  def go_to_url
    browser = firefox_browser
    browser.goto "https://www.bluecrossmn.com/providers/provider-medical-affairs/pharmacy-utilization-management"
    binding.pry
    collect_links(browser)
  end

  def next_button browser
    browser.a(title: 'Go to next page').click
    sleep 2
    collect_links(browser)
  end

  def collect_links(browser)
    links = browser.div(class: 'views-element-container').links(href: /pdf/)
     #links = browser.table(class: 'table table-striped views-table views-view-table cols-4 sticky-enabled sticky-table').links(href: /pdf/)
    links.each do |link|
      @@file_url_list << [link.href, link.name]
    end

    next_button browser if browser.a(title: 'Go to next page').exists?
  end
  def total_links
    puts "total links #{@@file_url_list.count}"
  end
  
end

obj = Test1.new
obj.go_to_url
obj.total_links
