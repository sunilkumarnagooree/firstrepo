require 'watir'
require 'pry'
browser = Watir::Browser.new :firefox
browser.goto "https://www.bluecrossmn.com/providers/provider-medical-affairs/pharmacy-utilization-management"

 table = browser.div(class: 'views-element-container').table.tbody
 table.trs.each do |tr|
 text = tr.tds[1].text
 puts text
end
