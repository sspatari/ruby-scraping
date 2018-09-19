require 'watir'

url = "https://my.fibank.bg/oauth2-server/login?client_id=E_BANK"
browser = Watir::Browser.new(:firefox)

browser.goto(url)
browser.link(:id => "demo-link").click

browser.close
