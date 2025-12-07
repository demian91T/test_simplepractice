require 'selenium-webdriver'
require 'json'
require 'minitest'
require 'minitest/assertions'
require_relative 'basepage'

include Minitest::Assertions
def assertions; @assertions ||= 0; end
def assertions=(value); @assertions = value;end

def create_driver
    options = Selenium::WebDriver::Firefox::Options.new
    options.add_preference("signon.rememberSignons", false)
    options.add_preference("network.cookie.cookieBehavior", 0)
    options.add_preference("dom.webnotifications.enabled", false)
    options.add_argument("--width=1920")
    options.add_argument("--height=1080")

    Selenium::WebDriver.for :firefox, options: options
end

def main

    file = File.read('login_data.json')
    data = JSON.parse(file)

    driver = create_driver
    page = BasePage.new(driver)

    url = data["url"]
    page.go_to_url(url)

    header_text=data["header"]
    assert page.text_exists_in?(:class,'content-header',header_text),
        "Wrong webpage"

    puts "Correct webpage"


    email = data["email"]
    page.write(:id,"user_email",email)

    password = data["password"]
    page.write(:id,"user_password",password)

    page.click(:id,"submitBtn")

    assert page.find(:id,'user-avatar'),
        "Failed logging"
    puts "Successful logging"
end

if __FILE__ == $0
    correct_login = main
end