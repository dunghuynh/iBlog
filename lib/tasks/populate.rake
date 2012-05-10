namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    [User, Article, Comment, Rating].each(&:delete_all)

    password = "123456"
    test_user = User.new(:email => 'huynhblog@gmail.com', :password => password)
    test_user.fullname = 'iBlog'
    test_user.shortbio = Populator.sentences(2..5)
    test_user.weburl = Faker::Internet.domain_name
    test_user.skip_confirmation!
    test_user.country_id = 1
    test_user.save
    populate_article_for_user(test_user.id)

    User.populate 5 do |user|
      user.fullname = Faker::Name.name
      user.email = Faker::Internet.free_email
      user.encrypted_password = test_user.encrypted_password
      # user.encrypted_password = BCrypt::Password.create("#{password}#{User.pepper}", :cost => User.stretches).to_s
      user.shortbio = Populator.sentences(2..5)
      user.weburl = Faker::Internet.domain_name
      user.confirmed_at = test_user.confirmed_at
      user.country_id = 1
      populate_article_for_user(user.id)
    end
  end

  def populate_article_for_user(user_id)
    Article.populate 5 do |article|
      article.user_id = user_id
      article.title = Faker::Lorem.sentence
      article.teaser = Populator.paragraphs(1..3) 
      article.body = Populator.paragraphs(2..10)
      article.state = Article::STATES.values
      article.created_at = article.updated_at = 3.months.ago..2.months.ago
      article.submitted = 1.month.ago..2.weeks.ago if article.state != Article::STATES[:draft]
      article.accepted =  10.days.ago..5.days.ago if article.state.in? Article::ACCEPTED_STATES
      Rating.populate 1 do |rating|
        rating.user_id = user_id
        rating.article_id = article.id
        rating.stars = Rating::STARS
      end
      Comment.populate 1 do |comment|
        comment.user_id = user_id
        comment.article_id = article.id
        comment.body = Populator.paragraphs(1..3)
        comment.created_at = comment.updated_at = 4.days.ago..Time.now
      end
    end
  end
end
