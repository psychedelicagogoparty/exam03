require 'rails_helper'

RSpec.describe "photos/index", type: :view do
  before(:each) do
    assign(:photos, [
      Photo.create!(
        :name => "Name",
        :content => "",
        :user_id => 2
      ),
      Photo.create!(
        :name => "Name",
        :content => "",
        :user_id => 2
      )
    ])
  end

  it "renders a list of photos" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
