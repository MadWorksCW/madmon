require 'spec_helper'

describe "watches/show" do
  before(:each) do
    @watch = assign(:watch, stub_model(Watch,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
