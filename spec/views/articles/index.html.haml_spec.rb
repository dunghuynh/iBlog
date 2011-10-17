require 'spec_helper'

describe "articles/index.html.haml" do
  before(:each) do
    assign(:articles, [
      stub_model(Article,
        :user_id => 1,
        :title => "Title",
        :teaser => "MyText",
        :body => "MyText",
        :version => "Version",
        :changelog => "MyText",
        :message => "Message",
        :freezebody => "MyText",
        :state => 1
      ),
      stub_model(Article,
        :user_id => 1,
        :title => "Title",
        :teaser => "MyText",
        :body => "MyText",
        :version => "Version",
        :changelog => "MyText",
        :message => "Message",
        :freezebody => "MyText",
        :state => 1
      )
    ])
  end

  it "renders a list of articles" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Version".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Message".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
