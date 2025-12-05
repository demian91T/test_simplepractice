require 'selenium-webdriver'
require 'json'
require_relative 'basepage'


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
    
    email = data["email"]
    page.write(:id,"user_email",email)

    password = data["password"]
    page.write(:id,"user_password",password)

    page.click(:id,"submitBtn")
end

if __FILE__ == $0
    correct_login = main
end