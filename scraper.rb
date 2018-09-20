require 'watir'

url = "https://my.fibank.bg/oauth2-server/login?client_id=E_BANK"
browser = Watir::Browser.new(:firefox)

browser.goto(url)
browser.link(:id => "demo-link").click
browser.ul(:id => "sidebar").li.wait_until_present
browser.ul(:id => "sidebar").link("ui-sref" => "app.layout.ACCOUNTS").click

browser.div(:class => ["box-border", "ng-scope"]).wait_until_present

browser.elements(:class => ["box-border", "ng-scope"]).each do |item|
  puts "**Account**:"
  puts "-name " + item.div(:index => 0).span.text
  puts "-currency " + item.div(:index => 1).span.text
  puts "-balance " + item.td.text
  puts "-nature " + item.div(:index => 0).h5.text
  puts
end

browser.close
