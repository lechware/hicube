class GenerateHicubeUsers < Mongoid::Migration
  def self.up
    puts "Creating Hicube User"
    Hicube::User.create!(email: 'admin@example.com', password: 'admin', name: 'Admin User')
  end

  def self.down
    users = Hicube::User.where(email: 'admin@example.com')
    return if users.nil? || users.empty?
    users.each do |user|
      user.delete
    end
  end
end