require 'test/unit'
require_relative './filter_out_of_bounds_specification'

# Class to test filter_out_of_bounds_specification
class FilterOutOfBoundsSpecficationTest < Test::Unit::TestCase
  def test_satisfied_by_returns_true_when_z_plus_offset_is_greater_than_size_z
    assert FilterOutOfBoundsSpecification.satisfied_by?(9, 10, 2)
    assert FilterOutOfBoundsSpecification.satisfied_by?(9, 10, 3)
    assert FilterOutOfBoundsSpecification.satisfied_by?(9, 10, 4)
  end

  def test_satisfied_by_returns_true_when_z_plus_offset_is_equal_to_size_z
    # since an array of size 10 is indexed from 0 to 9
    assert FilterOutOfBoundsSpecification.satisfied_by?(9, 10, 1)
  end

  def test_satisfied_by_returns_true_when_z_plus_zero_is_equal_to_size_z
    # since an array of size 7 is indexed from 0 to 6
    assert FilterOutOfBoundsSpecification.satisfied_by?(7, 7, 0)
  end

  def test_satisfied_by_returns_false_when_z_plus_zero_is_equal_to_size_z_minus_one
    assert !FilterOutOfBoundsSpecification.satisfied_by?(6, 7, 0)
  end

  def test_satisfied_by_returns_true_when_z_plus_offset_is_smaller_than_0
    assert FilterOutOfBoundsSpecification.satisfied_by?(2, 10, -3)
    assert FilterOutOfBoundsSpecification.satisfied_by?(2, 10, -4)
    assert FilterOutOfBoundsSpecification.satisfied_by?(2, 10, -5)
  end

  def test_satisfied_by_returns_false_when_z_plus_offset_falls_into_size_z
    assert !FilterOutOfBoundsSpecification.satisfied_by?(2, 10, 3)
    assert !FilterOutOfBoundsSpecification.satisfied_by?(2, 10, 4)
    assert !FilterOutOfBoundsSpecification.satisfied_by?(2, 10, 5)
  end

  def test_satisfied_by_returns_false_when_z_plus_negative_offset_falls_into_size_z
    assert !FilterOutOfBoundsSpecification.satisfied_by?(6, 10, -3)
    assert !FilterOutOfBoundsSpecification.satisfied_by?(6, 10, -4)
    assert !FilterOutOfBoundsSpecification.satisfied_by?(7, 10, -5)
  end
end
