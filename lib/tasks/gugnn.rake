require 'fileutils'
namespace :gugnn do
  desc "reset db, load seed, load sample, load theme sample"
  task :reload  => :environment do
    Rake::Task["db:remigrate"].invoke
    Rake::Task["db:seed"].invoke
    load File.join(Rails.root,'db/seeds.rb')

  end

  desc "load sample"
  task :load_sample  => :environment do
     load File.join(Rails.root,'db/samples.rb')
  end


end
