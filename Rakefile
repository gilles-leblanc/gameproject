libdir = File.dirname(__FILE__)+"/lib"
$: << libdir
confdir = File.dirname(__FILE__)+"/config"
$: << confdir

require 'rake/testtask'
require 'rubocop/rake_task'
require 'reek/rake/task'
require 'rspec/core/rake_task'
require 'environment'

$: << GAMEBOX_PATH
load "tasks/gamebox_tasks.rake"
STATS_DIRECTORIES = [
  %w(Source            src/), 
  %w(Config            config/), 
  %w(Maps              maps/), 
  %w(Unit\ tests       specs/),
  %w(Libraries         lib/),
].collect { |name, dir| [ name, "#{APP_ROOT}/#{dir}" ] }.select { |name, dir| File.directory?(dir) }

desc 'Generate and show sample city map'
task :output_city_map do
  ruby 'City/city_map_output.rb'
end

desc 'Generate and show sample world map'
task :output_world_map do
  ruby 'MapGenerator/map_output_test.rb MapGenerator'
end

desc 'Generate and show sample dungeon map'
task :output_dungeon_map do
  ruby 'Maze/dungeon_map_output.rb'
end

desc 'Run sample battle'
task :sample_battle do
  ruby 'Rules/battle_coordinator_test.rb'
end

desc 'Explore a sample map'
task :map_explorer do
  ruby 'map_explorer.rb'
end

desc 'Run RuboCop'
Rubocop::RakeTask.new(:rubocop) do |task|
  task.fail_on_error = false
end

desc 'Run Reek'
Reek::Rake::Task.new(:reek) do |t|
  t.fail_on_error = false
  t.verbose = true
  t.source_files = '*'
  t.reek_opts = '-n'
end

def generate_spec_task(directory)
  desc "#{directory} Specs"
  RSpec::Core::RakeTask.new("#{directory.downcase}_specs") do |t|
    t.pattern = "#{directory}/**/*_spec.rb"
    t.rspec_opts = '-c'
  end
end

SPEC_DIRS = %w|City MapGenerator RandomNameGeneration Rules|
SPEC_DIRS.each do |spec_dir|
  generate_spec_task spec_dir
end

desc 'All Specs'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = "*/**/*_spec.rb"
  t.rspec_opts = '-c'
end

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['./MapGenerator/filter_out_of_bounds_specification_test.rb',
                          './MapGenerator/particle_test.rb',
                          './Events/test/test*.rb']
  t.verbose = false
end
