require 'test_helper'

class TagTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @tag = tags(:school)
  end

  test "should be valid" do
    assert @tag.valid?
  end

  test "tag name should be present" do
    @tag.name = ""
    assert_not @tag.valid?
  end

  test "downcases tag name" do
    @tag = Tag.create(name: "YO")
    assert_equal @tag.name, "yo"
  end
end
