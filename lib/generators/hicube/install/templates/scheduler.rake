desc "Run sitemap generation"
task :update_sitemap => :environment do
  puts "Updating sitemap..."
  SitemapGenerator::Interpreter.run(:config_file => ENV["CONFIG_FILE"], :verbose => verbose)
  SitemapGenerator::Sitemap.ping_search_engines    
end

