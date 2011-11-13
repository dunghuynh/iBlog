require "spec_helper"

describe ErrorController do
  describe "routing" do
    it "routes to #index" do
      get("/error").should route_to("error#index")
    end

    it "routes to #not_found" do
      get("/error/404").should route_to("error#not_found")
    end
  end
end
