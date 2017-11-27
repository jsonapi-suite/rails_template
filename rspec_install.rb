run "bundle binstub rspec-core"
rails_command "generate rspec:install"
run "rm -rf test"
