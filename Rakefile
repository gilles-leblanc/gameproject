require 'rake/testtask'
require 'rubocop/rake_task'
require 'reek/rake/task'

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

desc 'City Specs'
task :city_specs do
  current_dir = Dir.pwd
  Dir.chdir('./City')
  system 'rspec'
  Dir.chdir(current_dir)
end

desc 'MapGenerator Specs'
task :map_specs do
  current_dir = Dir.pwd
  Dir.chdir('./MapGenerator')
  system 'rspec'
  Dir.chdir(current_dir)
end

desc 'RandomName Specs'
task :random_names_specs do
  current_dir = Dir.pwd
  Dir.chdir('./RandomNameGeneration')
  system 'rspec'
  Dir.chdir(current_dir)
end

desc 'Rules Specs'
task :rules_specs do
  current_dir = Dir.pwd
  Dir.chdir('./Rules')
  system 'rspec'
  Dir.chdir(current_dir)
end

desc 'All Specs'
task :specs => [:city_specs, :map_specs, :random_names_specs, :rules_specs] do
  puts 'Ran all specs'
end

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['./MapGenerator/filter_out_of_bounds_specification_test.rb',
                          './MapGenerator/particle_test.rb',
                          './Events/test/test*.rb']
  t.verbose = false
end

desc 'All'
task :all => [:specs, :test, :rubocop] do
  puts 'Ran all tests and specs'
end

task :default => :all