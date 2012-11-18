
$LOAD_PATH.unshift File.expand_path('/Users/johan/git/puppet-parser/lib')

require 'puppet-classparser'
require 'rake'
require 'rake/tasklib'

desc 'Run puppet-parser'
task :parse do
  matched_files = FileList['**/*.pp']
  PuppetClassParser::Runner.run(matched_files)
end
