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

  def get_server_from_env_variable(name)
    fail "Please set the server address using the environment variable #{name}" if ENV[name].to_s.empty?
    ENV[name]
  end

  desc "Deploy to localhost"
  task :local => :package do
    deploy('localhost')
  end

  desc "Deploy to test environment"
  task :test do
    deploy("app-server.dev")
  end

  desc "Deploy to staging environment"
  task :staging do
    server = get_server_from_env_variable('OD4D_STAGING_SERVER')
    deploy(server)
  end

  desc "Deploy to production environment"
  task :production do
    server = get_server_from_env_variable('OD4D_PROD_SERVER')
    deploy(server)
  end

end
