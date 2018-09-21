require 'watir'
require 'active_support/time'
require_relative 'account'
require_relative 'transaction'

class Scraper
  attr_accessor :accounts, :browser

  def openBrowser # use firefox browser
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
        item.td.text.to_f.round(2),
        item.div(:index => 0).span.text
      )
    end
  end

  def accessTransactionsPage
    @browser.ul(:class => ["tab-nav", "list-inline", "box-border"]).li(:index => 2).click
  end

  def setTransactionsFromDate # 2 months ago
    fromDate = (Time.now - 2.month).strftime("%d/%m/%Y")
    @browser.form.div(:id => "sg-date-from").input.to_subtype.set(fromDate)
    @browser.form.div(:id => "sg-date-from").input.send_keys(:enter)
  end

  def extractTransactions #for last 2 months
    ul = @browser.form.div(:name => "Iban").button.parent.ul
    liCount = ul.lis.count

    (1..liCount-1).each do |index|
      @browser.form.div(:name => "Iban").button.click! # exclamation used to solve is not clickable at point error
      @browser.div(:class => ["search-result", "ng-scope"]).wait_until_present

      #detect to which account to add the transaction
      accountName = ul.li(:index => index).span.text
      account = @accounts.detect { |account| account.name.casecmp?(accountName)}

      ul.li(:index => index).click #select account
      @browser.button(:id => "button").click!

      #get transactions for account
      transactions = @browser.div(:class => ["search-result", "ng-scope"]).tbody.trs.map do |row|
        Transaction.new(
          row.td(:index => 1).span.text,
          row.td(:index => 4).p.text,
          row.td(:index => 3).span.text.to_f.round(2) - row.td(:index => 2).span.text.to_f.round(2)
        )
      end

      #push transactions to account
      account.transactions.push(*transactions)
    end
  end

  def printAccountsData
    puts "Accounts data"
    @accounts.each { |account| puts account.to_s}
  end

  def printAccountsJson
    puts "Accounts data json"
    accountsJson = {:accounts => @accounts.map { |account| account.to_hash}}
    puts JSON.pretty_generate(accountsJson)
  end

  def printLastTwoMonthsTransactions
    puts "\nLast 2 month transactions"
    accounts.each do |account|
      account.transactions.each do |transaction|
        puts transaction
        puts "-account-name #{account.name}\n\n"
      end
    end
  end

  def closeBrowser
    @browser.close
  end

end

scraper = Scraper.new
scraper.openBrowser
scraper.accessAccountsPage
scraper.extractAccountsData
scraper.accessTransactionsPage
scraper.setTransactionsFromDate
scraper.extractTransactions
scraper.printAccountsData
scraper.printAccountsJson

scraper.printLastTwoMonthsTransactions
scraper.closeBrowser
