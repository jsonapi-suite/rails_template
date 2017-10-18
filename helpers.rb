Thor::Base.shell = Thor::Shell::Color

def truthy?(statement)
  val = ask(statement)
  ['y', 'yes', ''].include?(val)
end

def eval_template(name)
  instance_eval(File.read(File.dirname(__FILE__) + "/#{name}.rb"))
end

def api_namespace
  @api_namespace ||= begin
    prompt \
      header: "What is your API namespace?",
      description: "This will be used as a route prefix, e.g. if you want the route '/books_api/v1/authors' your namespace would be 'books_api'",
      default: 'api'
  end
end

def prompt(header: nil, description: nil, default: nil)
  say(set_color("\n#{header}", :magenta, :bold)) if header
  say("\n#{description}") if description
  answer = ask(set_color("\n(default: #{default}):", :magenta, :bold))
  answer = default if answer.blank? && default != 'nil'
  say(set_color("\nGot it!\n", :white, :bold))
  answer
end
