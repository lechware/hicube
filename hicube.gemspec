$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "hicube/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "hicube"
  s.version     = Hicube::VERSION
  s.authors     = ["Gaurav Cheema"]
  s.email       = ["gcheema@tecfoundary.com"]
  s.homepage    = "https://github.com/tecfoundary/hicube"
  s.summary     = "Simple CMS"
  s.description = "Simple CMS"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.0"

  # Admin theme
  s.add_dependency "adminlte-rails"

  # Image manas.add_dependencyent
  s.add_dependency "carrierwave-aws"

  # Support for orm mapper
  s.add_dependency "carrierwave-mongoid" #, require: "carrierwave/mongoid"

  # Security
  s.add_dependency "devise"

  # Google Analytics
  s.add_dependency "google-analytics-rails"

  # This makes links to work as per prior to RAILS v 4.0.
  s.add_dependency "jquery-turbolinks"

  # Use jQuery as the JavaScript library
  s.add_dependency "jquery-rails", "~> 4.0.0.beta2"

  s.add_dependency 'jquery-datatables-rails', '~> 3.1.1'

  # Pagination
  s.add_dependency "kaminari"

  # Bootstrap
  s.add_dependency "less-rails-bootstrap"

  # Rails Fontawesome support
  s.add_dependency "font-awesome-rails"

  # Mongoid
  s.add_dependency "mongoid"

  s.add_dependency "mongoid-slug"
  
  # Pagedown - markup editor used by Stackoverflow
  s.add_dependency "pagedown-bootstrap-rails"

  # Required by Slim engine to render markdown
  s.add_dependency "redcarpet"

  # Slim Templates
  s.add_dependency "slim-rails"

  # Use SCSS for stylesheets
  s.add_dependency "sass-rails", "~> 5.0.0.beta1"

  # Use CoffeeScript for .coffee assets and views
  s.add_dependency "coffee-rails", "~> 4.1.0"

  # Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
  s.add_dependency "turbolinks"

  # needed as bootstrap rails uses less
  s.add_dependency 'therubyracer'

  # Use Uglifier as compressor for JavaScript assets
  s.add_dependency "uglifier", ">= 1.3.0"

  s.require_path = 'lib'

end
