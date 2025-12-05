require 'selenium-webdriver'

class BasePage
    attr_reader :driver, :wait

    def initialize(driver, timeout = 10)
        @driver = driver
        @wait = Selenium::WebDriver::Wait.new(timeout: timeout)
    end

    def find(by, selector)
        wait.until {driver.find_element(by, selector)}
    end

    def go_to_url(url)
        driver.get(url)
    end    

    def click(by, selector)
        element = wait.until {driver.find_element(by, selector)}
        element.click
        element
    end

    def write(by, selector, text)
        element = wait.until {driver.find_element(by, selector)}
        element.clear
        element.send_keys(text)
        element
    end

    def exists?(by, selector)
        begin
            wait.until {driver.find_element(by, selector)}
            true
        rescue Selenium::WebDriver::Error::TimeoutError
            false
        end
    end
end