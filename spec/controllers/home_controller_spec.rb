require 'spec_helper'

describe HomeController do
  render_views

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end

    it "should have the right title" do
      visit 'index'
      page.should have_css('h1')
      # response.should have_selector("h1", :content => "Home#index")
      page.should have_content('Home#index')
    end
  end

  describe "GET 'about'" do
    it "returns http success" do
      get 'about'
      response.should be_success
    end
  end

end
