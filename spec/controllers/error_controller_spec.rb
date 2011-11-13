require 'spec_helper'

describe ErrorController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET '404'" do
    it "returns http success" do
      get 'not_found'
      response.should be_success
    end
  end

end
