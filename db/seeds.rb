puts "Seeding..."
#User.create(name: "Jesse", password: "111111", password_confirmation: "111111", email: "savvyjesse@aol.com")

if Rails.env == "development"
  #create users
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
  100.times do |i|
    Comment.create(post_id: Faker::Number.within(range: 1..100), user_id: Faker::Number.within(range: 1..20), body: Faker::TvShows::SouthPark.quote)
  end

  #attach profile pictures
  20.times do |i|
    user = User.find(i+1)
    user.profile_picture.attach(io: File.open("./app/assets/images/#{i+1}.png"), filename: "#{i+1}.png")
    user.save
    puts "...done"
  end
end

if Rails.env == "production"
  puts "SHOULD NOT TRIGGER IN DEVELOPMENT"
  #start from this id+1
  start_from = (User.last.id.to_i + 1)
  start_from_posts = (Post.last.id.to_i + 1)
  #create users starting after last current user id
  20.times do |i|
    User.create(name: Faker::Name.unique.name, email: "#{start_from}@aol.com", password: "111111", password_confirmation: "111111")
    user = User.find(start_from)
    #attach profile_pictures for new random users 
    user.profile_picture.attach(io: File.open("./app/assets/images/#{i+1}.png"), filename: "#{i+1}.png")

    5.times do 
      user.posts.create(body: Faker::Quote.famous_last_words)
    end
  end
  #create comments for users starting after last real user id
  100.times do
    last_post = Post.last.id.to_i
    last_user = User.last.id.to_i
    Comment.create(post_id: Faker::Number.within(range: start_from_posts..last_post), user_id: Faker::Number.within(range: start_from..last_user), body: Faker::TvShows::SouthPark.quote)
  end
end