iBlog
-----
Personal experiments with Rails.

See [CHANGELOG](https://github.com/DungHuynh/iBlog/blob/master/CHANGELOG.md)

## 0. Add Machinist 2 and fix auto generated Rspec:

[Machinist](https://github.com/notahat/machinist)`Gemfile`
    
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