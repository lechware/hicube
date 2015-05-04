# config/sitemap.rb
SitemapGenerator::Sitemap.default_host = ENV['HOST']
SitemapGenerator::Sitemap.adapter = SitemapGenerator::WaveAdapter.new
SitemapGenerator::Sitemap.sitemaps_host = "#{ENV["AWS_ASSET_HOST"]}/#{ENV['S3_BUCKET_NAME']}/#{ENV["S3_BUCKET_NAME"]}"
SitemapGenerator::Sitemap.public_path = Rails.root.join('tmp')
SitemapGenerator::Sitemap.sitemaps_path = "sitemaps/#{Rails.application.class.to_s.split('::').first}"


SitemapGenerator::Sitemap.create do
  # add '/contact', 'changefreq': 'weekly'
  Hicube::Page.all.each do |page|
    add "/#{page.slug}", lastmod: page.updated_at
  end
end

# Not needed if rake task is used
#SitemapGenerator::Sitemap.ping_search_engines