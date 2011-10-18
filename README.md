iBlog
-----
Personal experiments with Rails.

See [CHANGELOG](https://github.com/DungHuynh/iBlog/blob/master/CHANGELOG.md)

### 7. Install Devise s.3

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