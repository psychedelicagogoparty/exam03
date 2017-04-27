require 'rails_helper'

RSpec.describe "photos/edit", type: :view do
  before(:each) do
    @photo = assign(:photo, Photo.create!(
      :name => "MyString",
      :content => "",
      :user_id => 1
    ))
  end

  it "renders the edit photo form" do
    render

    assert_select "form[action=?][method=?]", photo_path(@photo), "post" do

      assert_select "input#photo_name[name=?]", "photo[name]"

      assert_select "input#photo_content[name=?]", "photo[content]"

      assert_select "input#photo_user_id[name=?]", "photo[user_id]"
    end
  end
end
