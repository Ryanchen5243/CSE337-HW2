
class Array
  alias_method :original_element_access, :[]
  alias_method :original_map_func, :map

  def [](arg)
    # puts "the provided arg is #{arg} of type #{arg.class}"
    if arg.class == Integer
      # puts "int arg detected"
      # check for valid index
      valid_index_range = (0...size).to_a + (-size..-1).to_a
      if valid_index_range.include?(arg)
        original_element_access(arg) # return element
      else
        return '\0' # change default nil
      end
    else # other access method ie. range
      # puts "some other class detected, defaulting to original behavior"
      original_element_access(arg)
    end
  end

  def map(seq=nil,&b)
    # puts "the provided sequence is #{seq}"
    # if no seq provided, default to original behavior
    if seq == nil
      # puts "the original imple"
      original_map_func(&b)
    else
      # If invalid sequence return empty array
      # apply code block only on elements in sequence
      # puts "custom map function? "
      if self[seq]
        self[seq].original_map_func(&b)
      else
        return []
      end
    end
  end
end
