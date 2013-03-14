
require 'puppet-parse'
require 'rake'
require 'rake/tasklib'

desc 'Run puppet-parse'
task :parse do
  matched_files = FileList['**/*.pp']

  if ignore_paths = PuppetParse.configuration.ignore_paths
    matched_files = matched_files.exclude(*ignore_paths)
  end

  run = PuppetParse::Runner.new
  puts run.run(matched_files.to_a).to_yaml
end
