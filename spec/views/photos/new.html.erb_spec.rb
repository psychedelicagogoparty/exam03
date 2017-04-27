require 'rails_helper'

RSpec.describe "photos/new", type: :view do
  before(:each) do
    assign(:photo, Photo.new(
      :name => "MyString",
      :content => "",
      :user_id => 1
    ))
  end

  it "renders new photo form" do
    render

    assert_select "form[action=?][method=?]", photos_path, "post" do

      assert_select "input#photo_name[name=?]", "photo[name]"

      assert_select "input#photo_content[name=?]", "photo[content]"

      assert_select "input#photo_user_id[name=?]", "photo[user_id]"
    end
  end
end
