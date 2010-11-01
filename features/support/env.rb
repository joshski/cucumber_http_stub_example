require File.join(File.dirname(__FILE__), 'stub_server')

class WebDriverStoryClient
  def initialize(server)
    @server = server
    require 'selenium-webdriver'
    @driver = Selenium::WebDriver.for(:firefox)
    @driver.navigate.to(server.url("/app.html"))
    at_exit do
      @driver.close
    end
  end
  
  def press_up
    @driver.execute_script("window.controller.up()")
  end
  
  def press_down
    @driver.execute_script("window.controller.down()")
  end
  
  def select
    @driver.execute_script("window.controller.select()")
  end
  
  def current_story
    @driver.first(:xpath, "//[@class='highlight']").text
  end
  
  def story_body
    @driver.first(:xpath, "//p").text
  end
end

Before do
  $story_server = StubServer.new('localhost', 9293)
  app_dir = File.join(File.dirname(__FILE__), '..', '..')
  $story_server.register("/", Mongrel::DirHandler.new(app_dir))
  $story_server.start
end

After do
  $story_server.stop
end