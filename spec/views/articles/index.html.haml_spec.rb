require 'spec_helper'

describe "articles/index.html.haml" do
  before(:each) do
    assign(:articles, [
      stub_model(Article,
        :user_id => 1,
        :title => "title",
        :teaser => "teaser",
        :body => "body",
        :version => "version",
        :changelog => "changelog",
        :message => "message",
        :freezebody => "freezebody",
        :state => 2,
        :created_at => Time.now
      ),
      stub_model(Article,
        :user_id => 1,
        :title => "title",
        :teaser => "teaser",
        :body => "body",
        :version => "version",
        :changelog => "changelog",
        :message => "message",
        :freezebody => "freezebody",
        :state => 2,
        :created_at => Time.now
      )
    ])
  end

  it "renders a list of articles" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select ".title", :text => "title".to_s, :count => 2
    assert_select ".teaser", :text => "teaser".to_s, :count => 2
  end
end
