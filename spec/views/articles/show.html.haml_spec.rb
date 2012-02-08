require 'spec_helper'

describe "articles/show.html.haml" do
  before(:each) do
    @article = assign(:article, stub_model(Article,
      :user_id => 1,
      :title => "MyTitle",
      :teaser => "MyTeaser",
      :body => "MyBody",
      :version => "Version",
      :changelog => "MyText",
      :message => "Message",
      :freezebody => "MyText",
      :state => 1,
      :user => stub_model(User, :fullname => "user name")
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/user name/)
    rendered.should match(/Title/)
    rendered.should match(/MyTeaser/)
    rendered.should match(/MyBody/)
  end
end
