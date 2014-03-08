require 'spec_helper'

describe "watches/new" do
  before(:each) do
    assign(:watch, stub_model(Watch,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new watch form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", watches_path, "post" do
      assert_select "input#watch_name[name=?]", "watch[name]"
    end
  end
end
