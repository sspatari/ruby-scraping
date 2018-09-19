require 'watir'

url = "https://my.fibank.bg/oauth2-server/login?client_id=E_BANK"
browser = Watir::Browser.new(:firefox)

browser.goto(url)

puts browser.title

browser.close
