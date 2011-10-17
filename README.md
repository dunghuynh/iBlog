iBlog
-----
Based on communityguides.eu [tutorial](http://www.communityguides.eu/articles/1) and other tutorials, cheatsheets...

### 1. Setup Git

    $ ssh-keygen -t rsa -C "your_email@youremail.com"
    
Then add the content of `id_rsa.pub` to github.com `Account Settings” > Click “SSH Public Keys” > Click “Add another public key”`. Test with `$ ssh -T git@github.com`

    $ mkdir iblog
    $ git init
    $ git status
    $ git add .
    $ git commit -m "init"
    $ git remote add origin git@github.com:DungHuynh/iBlog.git
    $ git push origin master

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
    
### 2. Init Rails project

    $ rails new iblog -T
    
Option -T to skip Test::Unit files (since we you RSpec)

### 3. Use some Gems

Insert gems to `Gemfile` then `bundle install`

    production: haml-rails, devise
    test: rspec-rails, cucumber-rails, capybara, database_cleaner
    
Install rspec and cucumber

    $ rails generate rspec:install
    $ rails generate cucumber:install --capybara --rspec

...