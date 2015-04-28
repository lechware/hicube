class GenerateHicubePages < Mongoid::Migration
  def self.up
    puts "Creating Hicube Index Page"
    Hicube::Page.create!(title: 'Index', body: "body\n\tb This is index page")
  end

  def self.down
    pages = Hicube::Page.where(title: 'Index')
    return if pages.nil? || pages.empty?
    pages.each do |page|
      page.delete
    end
  end
end