class MultiRenderer < Redcarpet::Render::HTML
  include Redcarpet::Render::SmartyPants
end

module Hicube
  Markdown = Redcarpet::Markdown.new(MultiRenderer)
end
