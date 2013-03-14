
require 'puppet-parse'
require 'rake'
require 'rake/tasklib'

desc 'Run puppet-parse'
task :parse do
  matched_files = FileList['**/*.pp']
  run = PuppetParse::Runner.new
  puts run.run(matched_files.to_a).to_yaml
end
