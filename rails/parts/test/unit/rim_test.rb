require 'test_helper'

class RimTest < ActiveSupport::TestCase

  test "creates from CSV" do
    rim = Rim.from_csv("RM0001	Surly Large Marge DH 	Surly	559	536.00	0.00	32".split(/\t/))

    assert_equal "RM0001", rim.part_number
    assert_equal "Surly", rim.brand
    assert_equal "Large Marge DH", rim.description
    assert rim.verified?
    assert_equal 559, rim.size
    assert_equal 536.0, rim.erd
    assert_equal 0.0, rim.offset
    assert_equal 32, rim.hole_count
  end

end
