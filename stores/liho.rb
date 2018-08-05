module Stores
  def self.liho
    @driver.navigate.to 'http://www.streetdirectory.com/businessfinder/company_branch/163304/5890/'

    wait = Selenium::WebDriver::Wait.new(timeout: 10) # seconds
    wait.until { @driver.find_element(css: '#company_branch_container tr[id]') }
    items = @driver.find_elements(css: '#company_branch_container tr[id]')
    
    items.map { |item_elem|
      BobaShop.new(
        item_elem.find_element(css: '.company_branch_name').text,
        item_elem.find_element(css: '.company_branch_address').text,
        item_elem.find_elements(css: '.company_branch_phone').any? ?
          item_elem.find_element(css: '.company_branch_phone').text.scan(/Tel.+?:\s?(.+)/).flatten.first
          : nil,
        nil
      )
    }.reject { |shop| shop.title.empty? }
  end
end
