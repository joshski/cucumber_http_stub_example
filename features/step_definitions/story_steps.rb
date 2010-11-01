require 'mongrel'
require 'restclient'
require 'json'

Given /^the following top stories:$/ do |table|
  $story_server.top_stories = table.hashes
  @top_stories = JSON.parse(RestClient.get($story_server.top_stories_url).body)
end

When /^I select the story "([^\"]*)"$/ do |title|
  @story_client = WebDriverStoryClient.new($story_server)
  index = @top_stories.index { |story| story['title'] == title }
  (1..index).each { @story_client.press_down }
  @story_client.select
end

Then /^I should see the body "([^\"]*)"$/ do |expected_body|
  @story_client.story_body.should == expected_body
end
