require 'minitest/autorun'
require_relative 'array'
require_relative 'rgrep'

class TestCases < Minitest::Test
  # Array Test Cases
  def test_array
    a = [1, 2, 34, 5]
    assert_equal('\0', a[10])

    arr = [1, 2, 3]
    assert_equal 1, arr[0]
    assert_equal 2, arr[1]
    assert_equal 3, arr[2]
    assert_equal '\0', arr[3]
    assert_equal 2, arr[-2]
    assert_equal 3, arr[-1]
    assert_equal '\0', arr[-4]
    assert_equal [1, 2], arr[0..1]

    arr_1 = [1,2,34,5]
    assert_equal 2, arr_1[1]
    assert_equal '\0', arr_1[10]

    arr_2 = ['hello','bye','world','heeee']
    assert_equal 'hello', arr_2[0]
    assert_equal 'bye', arr_2[1]
    assert_equal 'world', arr_2[2]
    assert_equal 'heeee', arr_2[3]
    assert_equal '\0', arr_2[4]
    assert_equal '\0', arr_2[5]
    assert_equal '\0', arr_2[6]
    assert_equal 'heeee', arr_2[-1]
    assert_equal 'world', arr_2[-2]
    assert_equal 'bye', arr_2[-3]
    assert_equal 'hello', arr_2[-4]
    assert_equal '\0', arr_2[-5]
    assert_equal '\0', arr_2[-6]
    assert_equal '\0', arr_2[-7]
    assert_equal '\0', arr_2[100]
    assert_equal '\0', arr_2[-100]
    assert_equal ['hello','bye','world','heeee'], arr_2[0..3]
    assert_equal ['world','heeee'], arr_2[2..3]
    assert_equal ['bye','world','heeee'], arr_2[-3..-1]

    b = ["cat", "bat", "mat", "sat"]
    assert_equal ["Mat", "Sat"], b.map(2..4) { |x| x[0].upcase + x[1,x.length] }
    assert_equal ["Cat", "Bat", "Mat","Sat"], b.map { |x| x[0].upcase + x[1,x.length] }
    assert_equal ["Mat", "Sat"], b.map(2..10) { |x| x[0].upcase + x[1,x.length] }
    a = [1,2,34,5]
    assert_equal 2, a[1]
    assert_equal '\0', a[10]
    assert_equal [34.0, 5.0], a.map(2..4) { |i| i.to_f}
    assert_equal [1.0, 2.0, 34.0, 5.0], a.map { |i| i.to_f}

    b = ["cat", "bat", "mat", "sat"]
    assert_equal "sat", b[-1]
    assert_equal '\0', b[5]
    assert_equal ["Mat", "Sat"], b.map(2..10) { |x| x[0].upcase + x[1,x.length] }
    assert_equal ["Mat", "Sat"], b.map(2..4) { |x| x[0].upcase + x[1,x.length] }
    assert_equal ["Bat", "Mat", "Sat"], b.map(-3..-1) { |x| x[0].upcase + x[1,x.length] }
    assert_equal ["Cat", "Bat", "Mat", "Sat"], b.map { |x| x[0].upcase + x[1,x.length] }
  end


end
