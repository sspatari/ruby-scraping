require 'watir'

url = "https://my.fibank.bg/oauth2-server/login?client_id=E_BANK"
browser = Watir::Browser.new(:firefox)

browser.goto(url)
browser.link(:id => "demo-link").click
browser.ul(:id => "sidebar").li.wait_until_present
browser.ul(:id => "sidebar").link("ui-sref" => "app.layout.ACCOUNTS").click

browser.close
