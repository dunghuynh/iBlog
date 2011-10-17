require 'spec_helper'

describe "articles/edit.html.haml" do
  before(:each) do
    @article = assign(:article, stub_model(Article,
      :user_id => 1,
      :title => "MyString",
      :teaser => "MyText",
      :body => "MyText",
      :version => "MyString",
      :changelog => "MyText",
      :message => "MyString",
      :freezebody => "MyText",
      :state => 1
    ))
  end

  it "renders the edit article form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => articles_path(@article), :method => "post" do
      assert_select "input#article_user_id", :name => "article[user_id]"
      assert_select "input#article_title", :name => "article[title]"
      assert_select "textarea#article_teaser", :name => "article[teaser]"
      assert_select "textarea#article_body", :name => "article[body]"
      assert_select "input#article_version", :name => "article[version]"
      assert_select "textarea#article_changelog", :name => "article[changelog]"
      assert_select "input#article_message", :name => "article[message]"
      assert_select "textarea#article_freezebody", :name => "article[freezebody]"
      assert_select "input#article_state", :name => "article[state]"
    end
  end
end
