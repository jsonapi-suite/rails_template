$:.unshift File.dirname(__FILE__)
require 'helpers'

welcome = <<-STR
\n
Welcome to the JSONAPI Suite generator!
=======================================

This will take care of some boilerplate for you, like adding gem dependencies and rspec helpers.

If you're worried there might be too much magic here, feel free to run 'git diff' at the end to see what happened. You can also learn more at our documentation website, https://jsonapi-suite.github.io/jsonapi_suite
STR

say(set_color(welcome.rstrip, :cyan, :bold))
api_namespace

eval_template('gems')
eval_template('routes')

after_bundle do
  run "bin/spring stop"

  eval_template('rspec_install')
  git :init
  git add: '.'
  eval_template('rspec')
  rails_command("generate jsonapi_suite:install")
  eval_template('swagger')

  say(set_color("\nYou're all set! If you need help developing JSONAPI, please head to our documentation website: https://jsonapi-suite.github.io/jsonapi_suite\n", :green, :bold))
end
