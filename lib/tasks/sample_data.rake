namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Jonathan Pulice",
                 email: "jon.pulice@gmail.com",
                 password: "qwerty",
                 password_confirmation: "qwerty")
    admin.toggle!(:admin)
    
    #Add dummy users
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
    
    #Add posts for the first x users
    users = User.all(limit: 6)
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.microposts.create!(content: content) }
    end
    
  end
end