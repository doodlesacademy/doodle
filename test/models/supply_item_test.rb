require 'test_helper'

class SupplyItemTest < ActiveSupport::TestCase
  @@valid_params = {
    name: 'Great art supply',
    url: 'http://amazon.com/blah/blah/blah'
  }

  test "it should not be valid without name" do
    params = @@valid_params.keep_if { |k, _v| k != :name }
    item = SupplyItem.new(params)
    assert_not item.valid?
  end

  test "it should respond to #lessons" do
    params = @@valid_params
    item = SupplyItem.new(params)
    assert item.respond_to?('lessons')
  end

  test "has_link? should reflect presence/absence of url" do
    params = @@valid_params
    item = SupplyItem.new(params)
    assert item.has_link?

    item.url = nil
    assert_not item.has_link?
  end
end
