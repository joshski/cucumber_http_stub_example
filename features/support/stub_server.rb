require 'mongrel'
require 'json'

class StubServer < Mongrel::HttpServer
  def start
    Thread.new { self.run.join }
  end

  def stop
    super(true) # synchronous
  end
  
  def top_stories=(stories)
    top_stories_handler = TopStoriesHandler.new
    register(top_stories_path, top_stories_handler)
    stories.each_with_index do |story, index|
      story['url'] = story_path(index + 1)
      register(story['url'], StoryHandler.new(story))
      top_stories_handler.stories << { 'title' => story['title'], 'url' => story['url'] }
    end
  end
  
  def top_stories_url
    url(top_stories_path)
  end
  
  def top_stories_path
    "/stories/top"
  end
  
  def story_url(id)
    url(story_path(id))
  end
  
  def story_path(id)
    "/stories/#{id}.json"
  end
  
  def url(path='')
    "http://#{host}:#{port}#{path}"
  end
end

class TopStoriesHandler < Mongrel::HttpHandler
  attr_accessor :stories
  
  def initialize
    @stories = []
  end
  
  def process(request, response)
    response.start(200) do | head, out |
      head["Content-Type"] = "text/json"
      out.write(@stories.to_json)
    end
  end
end

class StoryHandler < Mongrel::HttpHandler
  def initialize(story)
    @story = story
  end
  
  def process(request, response)
    response.start(200) do | head, out |
      head["Content-Type"] = "text/json"
      out.write(@story.to_json)
    end
  end
end