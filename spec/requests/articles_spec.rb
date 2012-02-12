require 'spec_helper'

describe "Articles" do

  describe "GET /articles" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get articles_path
      response.status.should be(200)
    end

    # Capybara JavaScript
    # describe 'some stuff which requires js', :js => true do
      # it 'will use the default js driver'
      # it 'will switch to one specific driver', :driver => :webkit
    # end

    it "displays articles" do
      Article.make!(:title => "My article")
      visit articles_path
      page.should have_content("My article")
    end

    it "displays articles filtered by search query", :js => true do
      Article.make!(:title => "My article")
      Article.make!(:title => "Unknown")

      visit articles_path

      fill_in "search", :with => "Unknown"
      click_button "Search"
      # save_and_open_page
      page.should have_content("Unknown")
      page.should_not have_content("My article")
    end
  end

end
