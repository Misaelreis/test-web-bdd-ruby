require 'capybara/cucumber'
require 'selenium-webdriver'
require 'site_prism'
require_relative 'page_helper.rb'
#require_relative 'ajuda.rb'

BROWSER = ENV['BROWSER']
AMBIENTE = ENV['AMBIENTE']
CONFIG = YAML.load_file(File.dirname(__FILE__) + "/ambientes/#{AMBIENTE}.yml") #homolog.yml

World(PageObjects)
#World(Helper)
Capybara.register_driver :selenium do |app|

    if BROWSER.eql?('chrome')
        Capybara::Selenium::Driver.new(app, :browser => :chrome)

    elsif BROWSER.eql?('chrome_headless')
        Capybara::Selenium::Driver.new(app, :browser =>:chrome,
        desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(
        'chromeOptions' => {'args' =>['--headless', 'disable-gpu']}
        )
        )

        #elsif BROWSER.eql?('firefox')
        #Capybara::Selenium::Driver.new(app, :browser => :firefox, :marionette => true)
        #elsif BROWSER.eql?('ie')
        #Capybara::Selenium::Driver.new(app, :browser => :internet_explorer)
        #elsif BROWSER.eql?('safari')
        #Capybara::Selenium::Driver.new(app, :browser => :safari)
        #elsif BROWSER.eql?('poltergeist')
        #options = {js_erros: false}
        #Capybara::Poltergeist::Driver.new(app, options)
    end

end

Capybara.configure do |config|
    config.default_driver = :selenium_headless
    config.app_host = CONFIG['url_padrao']
    config.default_max_wait_time = 5
end