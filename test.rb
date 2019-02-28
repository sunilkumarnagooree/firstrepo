require_relative 'base'
require 'parallel'

class Test < Base
  @@file_url_list = []
  def fetch_content
    browser = firefox_browser
    browser.goto 'http://www.iowamedicaidpdl.com/pa_forms'
    collect_links browser
  end

  def collect_links browser
   puts "=======called--1"
   table = browser.div(class: 'primaryContent').table
   links = table.links
   links.each do |link|
    next unless (link.href.end_with? '.pdf')
    @@file_url_list << {file_name: link.text, href: link.href, file_label: link.text }
   end
   if browser.link(id: 'DataTables_Table_0_next').attribute_value('class').include? 'disabled'
    browser.goto 'http://www.iowamedicaidpdl.com/pa_forms'
   else
   browser.link(id: 'DataTables_Table_0_next').click
   collect_links browser
   end
  end

  def links_count
    puts @@file_url_list.count
  end
  def download_all_links
    Parallel.map(@@file_url_list, in_threads: 5) do link
      agent = Mechanize.new
      agent.pluggable_parser.default = Mechanize::Download
      agent.get(link.href).save(File.join(Dir.home,'Download', link.text))
    end
  end

end

obj = Test.new
obj.fetch_content
obj.links_count
# obj.download_all_links
