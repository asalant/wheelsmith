require 'test_helper'

class HubTest < ActiveSupport::TestCase

  test "creates rear from CSV" do
    hub = Hub.from_csv("CR6030	Kris Holm 36H unicycle hub, 127mm crankset, blk	Kris Holm	0.00	0.00	0.00	0.00	0	56.00	56.00	33.50	33.50	36".split(/\t/))

    assert_equal "CR6030", hub.part_number
    assert_equal "Kris Holm", hub.brand
    assert_equal "36H unicycle hub, 127mm crankset, blk", hub.description
    assert hub.rear?
    assert hub.verified?
    assert_equal 56.0, hub.left_flange_diameter
    assert_equal 33.5, hub.left_flange_to_center
    assert_equal 56.0, hub.right_flange_diameter
    assert_equal 33.5, hub.right_flange_to_center
    assert_equal 36, hub.hole_count
  end


  test "creates front from CSV" do
    hub = Hub.from_csv("HU0570	DT Swiss 370 Front 28h Hub QR	DT Swiss	39.00	39.00	36.50	36.50	28	0.00	0.00	0.00	0.00	0".split(/\t/))

    assert_equal "HU0570", hub.part_number
    assert_equal "DT Swiss", hub.brand
    assert_equal "370 Front 28h Hub QR", hub.description
    assert !hub.rear?
    assert hub.verified?
    assert_equal 39.0, hub.left_flange_diameter
    assert_equal 36.5, hub.left_flange_to_center
    assert_equal 39.0, hub.right_flange_diameter
    assert_equal 36.5, hub.right_flange_to_center
    assert_equal 28, hub.hole_count
  end
end
