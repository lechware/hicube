class GenerateHicubeUsers < Mongoid::Migration
  def self.up
    puts "Creating Hicube User"
    Hicube::User.create!(account: Hicube::Account.first, email: 'admin@example.com', password: 'admin', name: 'Admin User', admin: true)
  end

  def self.down
    users = Hicube::User.where(email: 'admin@example.com')
    return if users.nil? || users.empty?
    users.each do |user|
      user.delete
    end
  end
end