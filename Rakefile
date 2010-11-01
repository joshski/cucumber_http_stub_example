require File.join(File.dirname(__FILE__), 'features', 'support', 'stub_server')

desc "Run a stub server for manual testing"
task :stub_server do
  server = StubServer.new('localhost', 9294)
  server.register("/", Mongrel::DirHandler.new("."))
  server.top_stories = [
    { 'title' => 'Explosives found in Yemen cargo',  'body' => 'constituted a credible terrorist threat' },
    { 'title' => 'Cameron claims EU budget success', 'body' => 'criticism he has agreed to an EU budget rise' }
  ]
  server.start.join
end