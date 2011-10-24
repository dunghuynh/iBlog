iBlog
-----
Personal experiments with Rails.
Based on communityguides.eu [tutorial](http://www.communityguides.eu/articles/1) and other tutorials, cheatsheets, advice...

## 1. Setup Git

    $ ssh-keygen -t rsa -C "your_email@youremail.com"
    
Then add the content of `id_rsa.pub` to github.com `Account Settings” > Click “SSH Public Keys” > Click “Add another public key”`. Test with `$ ssh -T git@github.com`

    $ mkdir iblog
    $ git init
    $ git status
    $ git add .
    $ git commit -m "init"
    $ git remote add origin git@github.com:DungHuynh/iBlog.git
    $ git push -u origin master

Additional config:

    $ git config --global -l
    
    $ git config --global user.name "Dung Huynh"
    $ git config --global user.email "your_email@youremail.com"
    
    $ git config --global github.user username
    $ git config --global github.token 0123456789yourf0123456789token
    
    # colorized output:
    $ git config --global color.ui always
    $ git config --global color.branch auto
    $ git config --global color.diff auto
    $ git config --global color.interactive auto
    $ git config --global color.status auto
    
    # SVN-like shortcuts for often used commands:
    $ git config --global alias.st status
    $ git config --global alias.ci commit
    $ git config --global alias.co checkout
    $ git config --global alias.br branch
    
    # TextMate as the default editor:
    $ git config --global core.editor "mate -w"
    # Opendiff (FileMerge) to resolve merge conflicts:
    $ git config --global merge.tool opendiff
    
## 2. [Init Rails project](https://github.com/DungHuynh/iBlog/commit/86a31ee13d0e5fb9a425418b5edd9cac73dcf62d)

    $ rails new iblog -T
    
Option -T to skip Test::Unit files (since we you RSpec)

## 3. [Use some Gems](https://github.com/DungHuynh/iBlog/commit/7ba7717257aa2d0bfaf0f76e9dbbdabcff357768)

Insert gems to `Gemfile` then `bundle install`

    production: haml-rails, devise
    test: rspec-rails, cucumber-rails, capybara, database_cleaner
    
Install rspec and cucumber

    $ rails generate rspec:install
    $ rails generate cucumber:install --capybara --rspec

## [bad features with web_steps.rb](https://github.com/DungHuynh/iBlog/commit/32b1603db6081a57dcacdbab40acee66accc53a1)

## 4. [Generate first scaffold: Article](https://github.com/DungHuynh/iBlog/commit/6507507b3fcc12031b14bd047b543988f817e5a3)

    $ rails generate scaffold Article user_id:integer title:string teaser:text body:text version:string changelog:text message:string freezebody:text state:integer submitted:date accepted:date
    $ rake db:migrate
    $ rails server
    
## 5. [Install Devise s.1](https://github.com/DungHuynh/iBlog/commit/13836759512b7397ebf87ab5a3d984f6db348e77)
    $ rails generate devise:install

Now we are prompted for 4 things:

    1.  config/environments/development.rb: add “config.action_mailer.default_url_options = { :host => ‘localhost:3000’ }”
    2.  config/routes.rb: add root :to => “article#index” (and delete public/index.html if you have not done before)
    3.  views/layouts/application.html.haml: add flash messages:
            %p.notice= notice
            %p.alert= alert
    4. If you are deploying Rails 3.1 on Heroku, you may want to set:
         config.assets.initialize_on_precompile = false
       On config/application.rb forcing your application to not access the DB
       or load models when precompiling your assets.

## 6. [Install Devise s.2](https://github.com/DungHuynh/iBlog/commit/42468cfcf4214efe6ae5380d0a3906f392efa53e)

Send email using Gmail. Add to `config/environments/development.rb`

    # Send emails via Gmail
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      :address              => "smtp.gmail.com",
      :port                 => 587,
      :domain               => 'gmail.com',
      :user_name            => 'yourname@gmail.com',
      :password             => 'yourpassword',
      :authentication       => 'plain',
      :enable_starttls_auto => true  }

Generate Devise views. Option `-e haml` doesn't work anymore, so use html2haml.heroku.com to convert each .erb file in `app/views/devise` to .haml one

    $ rails generate devise:views -e haml

Generate user model

    $ rails generate devise User

## 7. [Install Devise s.3](https://github.com/DungHuynh/iBlog/commit/37e72cbf22dc6d494fb7c6846873fae1bb50a44b)

Add confirmable as we want the email address of our users to be verified and the migration has to be changed accordingly. We also add lockable to limit login attempts with wrong passwords. Add to file `app/models/user.rb`

    devise :confirmable, :lockable

And file `db/migrate/...devise_create_users.rb`

    def self.up
      create_table(:users) do |t|
        ...
        t.confirmable
        t.lockable
      end
      ...
      add_index :users, :confirmation_token, :unique => true
    end

Include navigation in view:

    app/views/layout/application.html.haml

Edit controller to authenticate user. `app/controllers/articles_controller.rb`

    # only index and show are accessible for non-authenticated users
    before_filter :authenticate_user!, :except => [:index, :show]

## 8. Change database to use MySql

## 0. Add some style

## 9. [Deploy to heroku](https://github.com/DungHuynh/iBlog/commit/0987b1b9c19bbe727152ffaf810b1c6f7dd4483d)

[Sign up for a Heroku account](http://api.heroku.com/signup)

    $ gem install heroku

Tell Heroku your public key so that you can use Git to push

    $ heroku keys:add
    
    $ heroku create iblog
    ( heroku create --stack cedar iblog) -> iblog.herokuapp.com -> Celadon Cedar instead of current stack Badious Bamboo
    
    $ git push heroku master
    ( git push heroku otherbranch:master)
    
## 10. [Add Machinist 2 and fix auto generated Rspec:](https://github.com/DungHuynh/iBlog/commit/f35416dc573901567c07b7d276d47f4a5cd2e89f)

[Machinist](https://github.com/notahat/machinist)
`Gemfile`

    gem 'machinist', '>= 2.0.0.beta2'

Run

    $ rails generate machinist:install

If you want Machinist to automatically add a blueprint to your blueprints file whenever you generate a model, add the following to your `config/application.rb` inside the Application class:

    config.generators do |g|
      g.fixture_replacement :machinist
    end

`spec/support/blueprints.rb`

    require 'machinist/active_record'

    User.blueprint do
      email { "user#{sn}@sample.com"}
      password {"123456"}
      confirmed_at {"2011-10-23 09:34:29"}
    end

Fix problem with machinist caching `config/environments/test.rb`

    # Machinist disabling caching
      Machinist.configure do |config|
        config.cache_objects = false
      end

Usage: `spec/controllers/articles_controller_spec.rb`

    describe ArticlesController do

      before (:each) do
          @user = User.make!
          sign_in @user
      end
      ...
    end