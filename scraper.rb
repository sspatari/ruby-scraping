require 'watir'
require_relative 'account'

class Scraper
  attr_accessor :accounts, :browser

  def openBrowser
    @browser = Watir::Browser.new(:firefox)
  end

  def accessAccountsPage
    url = "https://my.fibank.bg/oauth2-server/login?client_id=E_BANK"
    @browser.goto(url)
    @browser.link(:id => "demo-link").click
    @browser.ul(:id => "sidebar").li.wait_until_present
    @browser.ul(:id => "sidebar").link("ui-sref" => "app.layout.ACCOUNTS").click
    @browser.div(:class => ["box-border", "ng-scope"]).wait_until_present
  end

  def extractAccountsData
    @accounts = browser.elements(:class => ["box-border", "ng-scope"]).map do |item|
      Account.new(
        item.div(:index => 0).h5.text,
        item.div(:index => 1).span.text,
        item.td.text,
        item.div(:index => 0).span.text
      )
    end
  end

  def printAccountsData
    @accounts.each { |account| puts account.to_s}
  end

  def printAccountsJson
    accountsJson = {:accounts => @accounts.map { |account| account.to_hash}}
    puts JSON.pretty_generate(accountsJson)
  end

  def closeBrowser
    @browser.close
  end

end

scraper = Scraper.new
scraper.openBrowser
scraper.accessAccountsPage
scraper.extractAccountsData
scraper.printAccountsData
scraper.printAccountsJson
scraper.closeBrowser
