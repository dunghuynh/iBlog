# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
IBlog::Application.initialize!

# Field with errors
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance_tag|
  if html_tag =~ /<(input|textarea|select)[^>]+class=/
    class_attribute = html_tag =~ /class=['"]/
    html_tag.insert(class_attribute + 7, "fieldWithErrors ")
  elsif html_tag =~ /<(input|textarea|select)/
    first_whitespace = html_tag =~ /\s/
    html_tag[first_whitespace] = " class='fieldWithErrors' "
  end
  html_tag
end
