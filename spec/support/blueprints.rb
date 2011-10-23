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
