insert_into_file "config/routes.rb", :after => "Rails.application.routes.draw do\n" do
  <<-STR
  scope path: '/#{api_namespace}' do
    scope path: '/v1' do
      # your routes go here
    end
  end
  STR
end
