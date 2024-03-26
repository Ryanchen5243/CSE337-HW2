require 'minitest/autorun'
require "Open3"
require_relative 'array'
require_relative 'rgrep'

class TestCases < Minitest::Test
  # Array Test Cases
  def test_array_1
    a = [1, 2, 34, 5]
    assert_equal('\0', a[10])
  end

  def test_array_2
    arr = [1, 2, 3]
    assert_equal 1, arr[0]
    assert_equal 2, arr[1]
    assert_equal 3, arr[2]
    assert_equal '\0', arr[3]
    assert_equal 2, arr[-2]
    assert_equal 3, arr[-1]
    assert_equal '\0', arr[-4]
    assert_equal [1, 2], arr[0..1]
  end
  def test_array_3
    arr_1 = [1,2,34,5]
    assert_equal 2, arr_1[1]
    assert_equal '\0', arr_1[10]
  end
  def test_array_4
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
  end
  def test_array_5
    b = ["cat", "bat", "mat", "sat"]
    assert_equal ["Mat", "Sat"], b.map(2..4) { |x| x[0].upcase + x[1,x.length] }
    assert_equal ["Cat", "Bat", "Mat","Sat"], b.map { |x| x[0].upcase + x[1,x.length] }
    assert_equal ["Mat", "Sat"], b.map(2..10) { |x| x[0].upcase + x[1,x.length] }
  end
  def test_array_6
    a = [1,2,34,5]
    assert_equal 2, a[1]
    assert_equal '\0', a[10]
    assert_equal [34.0, 5.0], a.map(2..4) { |i| i.to_f}
    assert_equal [1.0, 2.0, 34.0, 5.0], a.map { |i| i.to_f}
  end
  def test_array_7
    b = ["cat", "bat", "mat", "sat"]
    assert_equal "sat", b[-1]
    assert_equal '\0', b[5]
    assert_equal ["Mat", "Sat"], b.map(2..10) { |x| x[0].upcase + x[1,x.length] }
    assert_equal ["Mat", "Sat"], b.map(2..4) { |x| x[0].upcase + x[1,x.length] }
    assert_equal ["Bat", "Mat", "Sat"], b.map(-3..-1) { |x| x[0].upcase + x[1,x.length] }
    assert_equal ["Cat", "Bat", "Mat", "Sat"], b.map { |x| x[0].upcase + x[1,x.length] }
  end

  # rgrep test cases
  def test_rgrep_1
    setup_test_rgrep_txt_file
    output, status = Open3.capture2("ruby rgrep.rb")
    assert_equal "Missing required arguments\n", output
  end

  def test_rgrep_2
    setup_test_rgrep_txt_file
    output, status = Open3.capture2("ruby rgrep.rb test.txt")
    assert_equal "Missing required arguments\n", output
  end

  def test_rgrep_3
    setup_test_rgrep_txt_file
    output, status = Open3.capture2("ruby rgrep.rb test.txt -f")
    assert_equal "Invalid option\n", output
  end

  def test_rgrep_4
    setup_test_rgrep_txt_file
    output, status = Open3.capture2("ruby", "rgrep.rb", "test.txt", "-v", "-m", "\\d")
    assert_equal "Invalid combination of options\n",output
  end

  def test_rgrep_5
    setup_test_rgrep_txt_file
    output, status = Open3.capture2("ruby", "rgrep.rb", "test.txt", "-w", "road")
    assert_equal "101 broad road\n102 high road\n", output
  end

  def test_rgrep_6
    setup_test_rgrep_txt_file
    output, status = Open3.capture2("ruby", "rgrep.rb", "test.txt", "-w", "-m", "road")
    assert_equal "road\nroad\n", output
  end

  def test_rgrep_7
    setup_test_rgrep_txt_file
    output, status = Open3.capture2("ruby", "rgrep.rb", "test.txt", "-w", "-c", "road")
    assert_equal "2\n", output
  end

  def test_rgrep_8
    setup_test_rgrep_txt_file
    output, status = Open3.capture2("ruby", "rgrep.rb", "test.txt", "-p", "\\d\\d")
    assert_equal "101 broad road\n101 broad lane\n102 high road\n234 Johnson Street\nLyndhurst Pl 224\n", output
  end

  def test_rgrep_9
    setup_test_rgrep_txt_file
    output, status = Open3.capture2("ruby", "rgrep.rb", "test.txt", "-p", "-c", "\\d\\d")
    assert_equal "5\n", output
  end

  def test_rgrep_10
    setup_test_rgrep_txt_file
    output, status = Open3.capture2("ruby", "rgrep.rb", "test.txt", "-v", "^\\d\\d")
    assert_equal "Lyndhurst Pl 224\n", output
  end

  def test_rgrep_11
    setup_test_rgrep_txt_file
    output, status = Open3.capture2("ruby", "rgrep.rb", "test.txt", "-v", "-c", "^\\d\\d")
    assert_equal "1\n", output
  end

  def test_rgrep_12
    setup_test_rgrep_txt_file
    output, status = Open3.capture2("ruby", "rgrep.rb", "test.txt", "\\d\\d")
    assert_equal "101 broad road\n101 broad lane\n102 high road\n234 Johnson Street\nLyndhurst Pl 224\n", output
  end

  private
  def setup_test_rgrep_txt_file
    File.write('test.txt', "101 broad road\n101 broad lane\n102 high road\n234 Johnson Street\nLyndhurst Pl 224\n")
  end
end
