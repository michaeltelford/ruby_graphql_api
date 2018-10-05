require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.test_files = FileList['test/test_*.rb']
end

task default: :help

desc 'Print help info'
task :help do
    system 'bundle exec rake -D'
end

desc 'Run API on localhost:9292 in development mode'
task :serve do
  system 'bundle exec rackup -s puma -p 9292 -E development'
end

desc 'Run API on localhost:$PORT (default 9292) in deployment mode'
task :serve! do
  port = ENV['PORT'] || 9292
  system "bundle exec rackup -s puma -p #{port} -E deployment"
end
