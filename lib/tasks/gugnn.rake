require 'fileutils'
namespace :gugnn do
  desc "reset db, load seed, load sample, load theme sample"
  task :reload  => :environment do
    Rake::Task["db:remigrate"].invoke
    Rake::Task["db:seed"].invoke
    load File.join(Rails.root,'db/seeds.rb')

  end

  desc "load samples"
  task :load_samples  => :environment do
     load File.join(Rails.root,'db/samples.rb')
  end


end
