require 'machinist/active_record'

# Add your blueprints here.
#
# e.g.
#   Post.blueprint do
#     title { "Post #{sn}" }
#     body  { "Lorem ipsum..." }
#   end
#

User.blueprint do
  email { "user#{sn}@sample.com"}
  password {"123456"}
  confirmed_at {"2011-10-23 09:34:29"}
end

Article.blueprint do
  user { User.make! }
  title { "Article No.#{sn}" }
  body { "Article body: #{sn}"}
  teaser { "Article teaser: #{sn}"}
  version {"Article version: #{sn}"}
  changelog {"Article changelog: #{sn}"}
  message {"Article message: #{sn}"}
  state { 0 }
end

Comment.blueprint do
  user { User.make! }
  article { Article.make! }
  body { "Comment body: #{sn}" }
end
