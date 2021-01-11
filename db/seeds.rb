user1 = User.create(:username => "test 123", :email => "test123@aol.com", :password => "test")
user2 = User.create(:username => "test 321", :email => "test321@aol.com", :password => "test")

Tweet.create(:content => "this is a tweet", :user_id => user1.id)
Tweet.create(:content => "i am a boss at tweeting", :user_id => user1.id)
Tweet.create(:content => "first tweet", :user_id => user2.id)
