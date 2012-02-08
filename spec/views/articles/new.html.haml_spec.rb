require 'spec_helper'

describe "articles/new.html.haml" do
  before(:each) do
    assign(:article, stub_model(Article,
      :user_id => 1,
      :title => "MyString",
      :teaser => "MyText",
      :body => "MyText",
      :version => "MyString",
      :changelog => "MyText",
      :message => "MyString",
      :freezebody => "MyText",
      :state => 1
    ).as_new_record)
  end

  it "renders new article form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => articles_path, :method => "post" do
      assert_select "input#article_title", :name => "article[title]"
      assert_select "textarea#article_teaser", :name => "article[teaser]"
      assert_select "textarea#article_body", :name => "article[body]"
      assert_select "input#article_version", :name => "article[version]"
      assert_select "textarea#article_changelog", :name => "article[changelog]"
    end
  end
end
