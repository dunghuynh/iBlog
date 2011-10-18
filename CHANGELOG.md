iBlog
-----
Personal experiments with Rails.
Based on communityguides.eu [tutorial](http://www.communityguides.eu/articles/1) and other tutorials, cheatsheets, advice...

### 1. Setup Git

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
    
### 2. [Init Rails project](https://github.com/DungHuynh/iBlog/tree/86a31ee13d0e5fb9a425418b5edd9cac73dcf62d)

    $ rails new iblog -T
    
Option -T to skip Test::Unit files (since we you RSpec)

### 3. [Use some Gems](https://github.com/DungHuynh/iBlog/tree/7ba7717257aa2d0bfaf0f76e9dbbdabcff357768)

Insert gems to `Gemfile` then `bundle install`

    production: haml-rails, devise
    test: rspec-rails, cucumber-rails, capybara, database_cleaner
    
Install rspec and cucumber

    $ rails generate rspec:install
    $ rails generate cucumber:install --capybara --rspec

### [bad features with web_steps.rb](https://github.com/DungHuynh/iBlog/tree/32b1603db6081a57dcacdbab40acee66accc53a1)

### 4. [Generate first scaffold: Article](https://github.com/DungHuynh/iBlog/tree/6507507b3fcc12031b14bd047b543988f817e5a3)

    $ rails generate scaffold Article user_id:integer title:string teaser:text body:text version:string changelog:text message:string freezebody:text state:integer submitted:date accepted:date
    $ rake db:migrate
    $ rails server
    
### 5. [Install Devise s.1](https://github.com/DungHuynh/iBlog/tree/13836759512b7397ebf87ab5a3d984f6db348e77)
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

### 6. [Install Devise s.2](https://github.com/DungHuynh/iBlog/tree/42468cfcf4214efe6ae5380d0a3906f392efa53e)

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