require 'watir'
require 'mechanize'
require 'pry'
class Base

  def firefox_browser
    Watir::Browser.new :firefox
  end

end
