
desc "City Specs"
task :city_specs do
  current_dir = Dir.pwd
  Dir.chdir("./City")
  system "rspec"
  Dir.chdir(current_dir)
end

desc "MapGenerator Specs"
task :map_specs do
  current_dir = Dir.pwd
  Dir.chdir("./MapGenerator")
  system "rspec"
  Dir.chdir(current_dir)
end

desc "RandomName Specs"
task :random_names_specs do
  current_dir = Dir.pwd
  Dir.chdir("./RandomNameGeneration")
  system "rspec"
  Dir.chdir(current_dir)
end

desc "All Specs"
task :specs => [:city_specs, :map_specs, :random_names_specs] do
  puts "Ran all specs"
end

task :default => :specs