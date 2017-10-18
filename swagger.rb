# swagger
run "mkdir -p public/#{api_namespace}/docs"
inside("public/#{api_namespace}/docs") do
  run "git clone https://github.com/jsonapi-suite/swagger-ui.git && cp swagger-ui/prod-dist/* . && rm -rf swagger-ui"
end

gsub_file "public/#{api_namespace}/docs/index.html", "basePath: '/api'" do
  "basePath: '/#{api_namespace}'"
end

gsub_file "public/#{api_namespace}/docs/index.html", "/app." do |match|
  "/#{api_namespace}/docs#{match}"
end

github = prompt \
  header: "What is the Github URL for this project?",
  description: "This is used in the Swagger UI to link to your project. It does *not* end in .git. If you don't have a Github URL yet, make sure to edit public/#{api_namespace}/docs/index.html once you have one",
  default: 'nil'

if github.present?
  gsub_file "public/#{api_namespace}/docs/index.html", "githubURL: 'http://replaceme.com'" do
    "githubURL: '#{github}'"
  end
end

create_file 'app/controllers/docs_controller.rb' do
  title = prompt \
    header: "What is the Swagger title for this project?",
    description: "Should make sense in the sentence, 'Welcome to the <title> API'",
    default: 'Untitled'
  description = prompt \
    header: "What is the Swagger description for this project?",
    description: "HTML is OK here",
    default: '--'
  contact_name = prompt \
    header: "What is the Swagger contact name?",
    description: "e.g. 'John Doe'",
    default: '--'
  contact_email = prompt \
    header: "What is the Swagger contact email?",
    default: '--'

  <<-STR
require 'jsonapi_swagger_helpers'

class DocsController < ActionController::API
  include JsonapiSwaggerHelpers::DocsControllerMixin

  swagger_root do
    key :swagger, '2.0'
    info do
      key :version, '1.0.0'
      key :title, '#{title}'
      key :description, '#{description}'
      contact do
        key :name, '#{contact_name}'
        key :email, '#{contact_email}'
      end
    end
    key :basePath, '/#{api_namespace}'
    key :consumes, ['application/json']
    key :produces, ['application/json']
  end
end
  STR
end

insert_into_file "config/routes.rb", after: "scope path: '/#{api_namespace}' do\n" do
  "    resources :docs, only: [:index], path: '/swagger'\n\n"
end

insert_into_file "Rakefile", after: "require_relative 'config/application'\n" do
  "require 'jsonapi_swagger_helpers'\n"
end
