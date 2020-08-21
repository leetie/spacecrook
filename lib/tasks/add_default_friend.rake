namespace :add_default_friend do
  desc "creates friendships for each user and user 1"
  User.all.each do |u|
    #skip if user is user 1 
    if u.id == 1
      next
    end
    #skip if user is already friends with user 1
    if u.friends.ids.include?(1)
      next
    end

    Friendship.create(user_id: 1, friend_id: u.id)
    Friendship.create(user_id: u.id, friend_id: 1)
end
