File.open('all.rb', 'w') do |f|
  f.write("#{File.read("helpers.rb")}\n")
  f.write("#{File.read("welcome.rb")}\n")
  f.write("#{File.read("gems.rb")}\n")
  f.write("#{File.read("routes.rb")}\n")

  f.write("after_bundle do\n")
    f.write("run 'bin/spring stop'\n\n")
    f.write("#{File.read("rspec_install.rb")}\n")
    f.write("git :init\n")
    f.write("git add: '.'\n")
    f.write("#{File.read("rspec.rb")}\n")
    f.write("rails_command('generate jsonapi_suite:install')\n")
    f.write("#{File.read("swagger.rb")}\n")
  f.write("end\n") # after bundle
  f.write("say(set_color(\"\\nYou're all set! If you need help developing JSONAPI, please head to our documentation website: https://jsonapi-suite.github.io/jsonapi_suite\\n\", :green, :bold))")
end
