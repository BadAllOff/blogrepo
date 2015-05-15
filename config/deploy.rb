# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'badblog'
set :repo_url, "https://#{ENV['GITHUB_USERNAME']}:#{ENV['GITHUB_PASSWORD']}@github.com/RebelioUS/badblog5.git" # repo address
# set :git_https_username, ENV['GITHUB_USERNAME']
# set :git_https_password, ENV['GITHUB_PASSWORD']
set :deploy_to, '/opt/www/badblog'
set :user, 'deploy'
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets}

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  %w[start stop restart].each do |command|
    desc 'Manage Unicorn'
    task command do
      on roles(:app), in: :sequence, wait: 1 do
        execute "/etc/init.d/unicorn_#{fetch(:application)} #{command}"
      end
    end
  end

  after :publishing, :restart

end