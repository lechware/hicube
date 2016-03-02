class GenerateHicubeAccounts < Mongoid::Migration
  def self.up
    puts "Creating Hicube Account"
    Hicube::Account.create! ga: 'GA', domain: 'localhost:3000', 
      notify_email_html: "Please insert here HTML component of notification template", 
      notify_email_text: "Please insert here TEXT component of notification template"
  end

  def self.down
    Hicube::Account.first.delete unless Hicube::Account.first.nil?
  end
end
