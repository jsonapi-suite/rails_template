welcome = <<-STR
\n
Welcome to the JSONAPI Suite generator!
=======================================

This will take care of some boilerplate for you, like adding gem dependencies and rspec helpers.

If you're worried there might be too much magic here, feel free to run 'git diff' at the end to see what happened. You can also learn more at our documentation website, https://jsonapi-suite.github.io/jsonapi_suite
STR

say(set_color(welcome.rstrip, :cyan, :bold))
api_namespace
