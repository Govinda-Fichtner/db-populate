namespace :db do
  
  desc "Loads initial database models for the current environment."
  task :populate => :environment do
    require File.join(File.dirname(__FILE__), '/../lib', 'create_or_update')
    Dir[File.join(Rails.root, 'db', 'populate', '*.rb')].sort.each do |fixture| 
      load fixture 
      puts "Loaded #{fixture}"
    end
    (Dir[File.join(Rails.root, 'db', 'populate', Rails.env, '*.rb')] + Dir[File.join(Rails.root, 'db', 'populate', 'shared', '*.rb')]).sort{|x,y| File.basename(x) <=> File.basename(y)}.each do |fixture|
      load fixture 
      puts "Loaded #{fixture}"
    end
    Dir[File.join(Rails.root, 'db', 'populate', 'after', '*.rb')].sort.each do |fixture| 
      load fixture 
      puts "Loaded #{fixture}"
    end
  end
  
  desc "Runs migrations and then loads seed data"
  task :migrate_and_populate => [ 'db:migrate', 'db:populate' ]

  task :migrate_and_load => [ 'db:migrate', 'db:populate' ]
  
  desc "Drop and reset the database for the current environment and then load seed data"
  task :reset_and_populate => [ 'db:reset', 'db:populate']

  task :reset_and_load => [ 'db:reset', 'db:populate']
  
end