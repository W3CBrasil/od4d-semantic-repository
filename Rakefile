desc "Remove output folder"
task :clean do
  sh 'rm -rf ./output'
end

desc "Package for deployment"
task :package => :clean do
  sh './scripts/create-package.sh'
end

namespace :deploy do

  def deploy(server)
    configure_deploy_ssh_key(server)
    sh "./output/deploy.sh #{server}"
  end

  def configure_deploy_ssh_key(server)
    command = <<-eos
      echo "$DEPLOY_SSH_KEY" > ~/.ssh/deploy-key
      chmod 0600 ~/.ssh/deploy-key
      printf "\nHost #{server}\nUserKnownHostsFile /dev/null\nIdentityFile ~/.ssh/deploy-key\n" >> $HOME/.ssh/config
    eos
    sh command if ENV['CI']
  end

  desc "Deploy to localhost"
  task :local => :package do
    deploy('localhost')
  end

  desc "Deploy to development"
  task :development => :package do
    deploy('app-server.dev')
  end

  desc "Deploy to staging"
  task :staging => :package do
    fail "Please set the server address using the environment variable OD4D_STAGING_SERVER" if ENV['OD4D_STAGING_SERVER'].to_s.empty?
    deploy(ENV['OD4D_STAGING_SERVER'])
  end

  desc "Deploy to production"
  task :production => :package do
    fail "Please set the server address using the environment variable OD4D_PROD_SERVER" if ENV['OD4D_PROD_SERVER'].to_s.empty?
    deploy(ENV['OD4D_PROD_SERVER'])
  end

end
