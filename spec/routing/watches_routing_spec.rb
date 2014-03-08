require "spec_helper"

describe WatchesController do
  describe "routing" do

    it "routes to #index" do
      get("/watches").should route_to("watches#index")
    end

    it "routes to #new" do
      get("/watches/new").should route_to("watches#new")
    end

    it "routes to #show" do
      get("/watches/1").should route_to("watches#show", :id => "1")
    end

    it "routes to #edit" do
      get("/watches/1/edit").should route_to("watches#edit", :id => "1")
    end

    it "routes to #create" do
      post("/watches").should route_to("watches#create")
    end

    it "routes to #update" do
      put("/watches/1").should route_to("watches#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/watches/1").should route_to("watches#destroy", :id => "1")
    end

  end
end
