puts "Seeding..."
User.create(name: "Jesse", password: "111111", password_confirmation: "111111", email: "savvyjesse@aol.com")

#create profiles
20.times do |i|
  User.create(name: Faker::Name.unique.name, email: "#{i+1}@aol.com", password: "111111", password_confirmation: "111111")
end

#create posts
20.times do |i|
  user = User.find(i+1)
  5.times do
    user.posts.create(body: Faker::Quote.famous_last_words)
  end
end

#create comments
50.times do |i|
  Comment.create(post_id: Faker::Number.within(range: 1..100), user_id: Faker::Number.within(range: 1..20))
end

#attach profile pictures
# 21.times do |i|
#   user = User.find(i+1)
#   user.profile_picture.attach(Faker::Avatar.image)
#   user.save
# end