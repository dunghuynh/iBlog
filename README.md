iBlog
-----
Personal experiments with Rails.

See [CHANGELOG](https://github.com/DungHuynh/iBlog/blob/master/CHANGELOG.md)

### 6. Install Devise s.2

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