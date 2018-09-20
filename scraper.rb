require 'watir'
require_relative 'account'

url = "https://my.fibank.bg/oauth2-server/login?client_id=E_BANK"
browser = Watir::Browser.new(:firefox)

browser.goto(url)
browser.link(:id => "demo-link").click
browser.ul(:id => "sidebar").li.wait_until_present
browser.ul(:id => "sidebar").link("ui-sref" => "app.layout.ACCOUNTS").click

browser.div(:class => ["box-border", "ng-scope"]).wait_until_present

accounts = browser.elements(:class => ["box-border", "ng-scope"]).map do |item|
  Account.new(
    item.div(:index => 0).span.text,
    item.div(:index => 1).span.text,
    item.td.text,
    item.div(:index => 0).h5.text
  )
end

accounts.each do |account|
  print account
end

browser.close
