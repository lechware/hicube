class GenerateHicubePages < Mongoid::Migration
  def self.up
    puts "Creating Hicube Index Page"
    Hicube::Page.create!(title: 'Home', body: '*This is bold text*')
  end

  def self.down
    pages = Hicube::Page.where(title: 'Home')
    return if pages.nil? || pages.empty?
    pages.each do |page|
      page.delete
    end
  end
end