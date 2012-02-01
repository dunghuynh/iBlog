# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# See https://github.com/rails/rails/blob/59f7780a3454a14054d1d33d9b6e31192ab2e58b/activemodel/lib/active_model/mass_assignment_security/sanitizer.rb
# Allow mass assignment in seeds.rb
module ActiveModel
  module MassAssignmentSecurity
    module Sanitizer
      def sanitize(attributes)
        attributes
      end
    end
  end
end

User.delete_all
Article.delete_all

@user1 = User.create! :email => 'huynhblog@gmail.com', :password => '123456', :fullname => 'Huynh Blog', :country_id => '1', :weburl => 'http://www.google.com', :shortbio => 'Short biography of Admin'
@user1.confirm!

@user2 = User.create! :email => 'user2@gmail.com', :password => '123456', :fullname => 'Huynh Blog', :country_id => '1', :weburl => 'http://www.google.com', :shortbio => 'Short biography of User2'
@user2.confirm!

@user1.articles.create! :title => 'Article No. 1', :state => 1, :message => '', :version => 'Version Info', :changelog => 'Changelog', :submitted => Time.now, :accepted => Time.now + 2.day, :teaser => "Teaser 1", :body => "h1. Article 1"
@user1.articles.create! :title => 'Article No. 2', :state => 1, :message => '', :version => 'Version Info', :changelog => 'Changelog', :submitted => Time.now, :accepted => Time.now + 2.day, :teaser => "Teaser 2", :body => "h1. Article 2"
@user1.articles.create! :title => 'Article No. 3', :state => 2, :message => '', :version => 'Version Info', :changelog => 'Changelog', :submitted => Time.now, :accepted => Time.now + 2.day, :teaser => "Teaser 3", :body => "h1. Article 3"
@user1.articles.create! :title => 'Article No. 4', :state => 3, :message => '', :version => 'Version Info', :changelog => 'Changelog', :submitted => Time.now, :accepted => Time.now + 2.day, :teaser => "Teaser 4", :body => "h1. Article 4"
@user1.articles.create! :title => 'Article No. 5', :state => 4, :message => '', :version => 'Version Info', :changelog => 'Changelog', :submitted => Time.now, :accepted => Time.now + 2.day, :teaser => "Teaser 5", :body => "h1. Article 5"

(6..20).each do |i|
  @user2.articles.create! :title => "Article No. #{i}", :state => (i % 4 + 1), :message => '', :version => 'Version Info', :changelog => 'Changelog', :submitted => Time.now, :accepted => Time.now + 2.day, :teaser => "Teaser #{i}", :body => "h1. Article #{i}"
end
