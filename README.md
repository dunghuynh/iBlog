iBlog
-----
Personal experiments with Rails.

See [CHANGELOG](https://github.com/DungHuynh/iBlog/blob/master/CHANGELOG.md)

## 11. Speed up testing with Spork and Guard

### [Spork](http://ruby.railstutorial.org/chapters/static-pages#sec:spork)
`Gemfile`

    group :test do
      gem 'spork'
      
    end

Next, bootstrap the Spork configuration:

    spork --bootstrap

Edit RSpec configuration file, `spec/spec_helper.rb` so that the environment gets loaded in a `prefork` block. which arranges for it to be loaded only once.

    Spork.prefork do
      <old code goes here>
    end
    
    Spork.each_run do
    end

Similarly for the file:

    feature/support/env.rb

Run RSpec without Spork
    
    $ time rspec spec

Now with Spork

    $ spork           # for RSpec
    $ spork cucumber  # for Cucumber

Then leave the terminal there. Spork is ready and listening on 8989! ...    
In another terminal

    $ time rspec --drb spec/
    ($ time cucumber --drb)

Adding the --drb option to the `.rspec` file.

    --colour
    --drb

### [Guard](http://blog.carbonfive.com/2010/12/10/speedy-test-iterations-for-rails-3-with-spork-and-guard/)

Guard is a modular filesystem event monitor utility written in Ruby. We will utilize a plugin for Guard that allows us to monitor changes to Rails files and restart Spork when necessary:

Start Spork via Guard. The first thing we need to do is to tell Guard about spork.
Add guard definition to your `Guardfile` with:

    $ guard init spork
    $ guard init cucumber
    $ guard init rspec
    
    $ guard start
