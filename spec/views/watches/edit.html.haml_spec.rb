require 'spec_helper'

describe "watches/edit" do
  before(:each) do
    @watch = assign(:watch, stub_model(Watch,
      :name => "MyString"
    ))
  end

  it "renders the edit watch form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", watch_path(@watch), "post" do
      assert_select "input#watch_name[name=?]", "watch[name]"
    end
  end
end
