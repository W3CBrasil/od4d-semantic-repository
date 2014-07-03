
desc "Remove output folder"
task :clean do
  sh 'rm -rf ./output'
end

desc "Package for deployment"
task :package => :clean do
  sh './scripts/create-package.sh'
end

namespace :deploy do

  desc "Deploy semantic repository to locahost"
  task :local => :package do
    sh './output/deploy.sh'
  end

  desc "Deploy semantic repository to production server"
  task :production => :package do
    sh './output/deploy.sh production'
  end

end
