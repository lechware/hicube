class GenerateHicubePages < Mongoid::Migration
  def self.up
    puts "Setting Junction setting to false on all existing pages"
    Hicube::Page.unscoped.exists(junction: false).update_all(junction: false)
  end

  def self.down
    puts "Nothing to do here, its safe!"
  end
end