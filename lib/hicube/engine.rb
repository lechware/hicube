module Hicube
  class Engine < ::Rails::Engine
    isolate_namespace Hicube
    
    initializer 'hicube.assets.precompile' do |app|
      %w(stylesheets javascripts img).each do |sub|
        app.config.assets.paths << root.join('vendor', 'assets', sub)
      end
    end
  end
end
