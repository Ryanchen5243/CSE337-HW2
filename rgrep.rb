def run
  options = {w_flag: false, p_flag: false, v_flag: false, c_flag: false, m_flag: false}
  file_name = ARGV[0]
  if file_name.nil? || ARGV.size < 2
    puts "Missing required arguments"
    exit
  end

  pattern = ARGV[-1]
  if pattern[0] == '-'
    if !(pattern == "-w" || pattern == "-p" || pattern == "-v" || pattern == "-c" || pattern == "-m")
      puts "Invalid option"
    else
      puts "Missing required arguments"
    end
    exit
  end

  # process options
  ARGV[1..-2].each do |e|
    case e
    when "-w"
      options[:w_flag] = true
    when "-p"
      options[:p_flag] = true
    when "-v"
      options[:v_flag] = true
    when "-c"
      options[:c_flag] = true
    when "-m"
      options[:m_flag] = true
    else
      puts "Invalid option"
      exit
    end
  end

  # puts "The selected options are .... "
  # puts options

  # verify combination of options

  # :p_flag
  # :w_flag
  # :v_flag
  # :c_flag :w_flag
  # :c_flag :p_flag
  # :c_flag :v_flag
  # :m_flag :w_flag
  # :m_flag :p_flag
  #
  pattern_class = nil

  # puts "the detected pattern class is #{pattern.class}"

  if !options[:w_flag] && options[:p_flag] && !options[:v_flag] && !options[:c_flag] && !options[:m_flag]
    # puts "only p flag"
    pattern_class = Regexp
  elsif options[:w_flag] && !options[:p_flag] && !options[:v_flag] && !options[:c_flag] && !options[:m_flag]
    # puts "only w flag"
    pattern_class = String
  elsif !options[:w_flag] && !options[:p_flag] && options[:v_flag] && !options[:c_flag] && !options[:m_flag]
    # puts "only v flag"
    pattern_class = Regexp
  elsif options[:w_flag] && !options[:p_flag] && !options[:v_flag] && options[:c_flag] && !options[:m_flag]
    # puts "only w and c flags"
    pattern_class = String
  elsif !options[:w_flag] && options[:p_flag] && !options[:v_flag] && options[:c_flag] && !options[:m_flag]
    # puts "only p and c"
    pattern_class = Regexp
  elsif !options[:w_flag] && !options[:p_flag] && options[:v_flag] && options[:c_flag] && !options[:m_flag]
    # puts "only c and v"
    pattern_class = Regexp
  elsif options[:w_flag] && !options[:p_flag] && !options[:v_flag] && !options[:c_flag] && options[:m_flag]
    # puts "only m and w"
    pattern_class = String
  elsif !options[:w_flag] && options[:p_flag] && !options[:v_flag] && !options[:c_flag] && options[:m_flag]
    # puts "only m and p"
    pattern_class = Regexp
  elsif !options[:w_flag] && !options[:p_flag] && !options[:v_flag] && !options[:c_flag] && !options[:m_flag]
    # puts "no flags provided"
    options[:p_flag] = true # default flag
    pattern_class = Regexp
  end

  if pattern_class.nil?
    puts "Invalid combination of options"
    exit
  end

  if !File.exist?(file_name)
    puts "File doesn't exist"
    exit
  end

  fileContents = File.read(file_name)
  result_output = ""

  pattern = options[:w_flag] ? /\b#{pattern}\b/ : Regexp.new(pattern)

  # perform match
  if options[:w_flag] || options[:p_flag] || options[:v_flag]

    if options[:v_flag]
      pattern = /^(?!.*#{pattern})/
    end

    if options[:c_flag]
      temp = fileContents.split("\n")
      num_lines = 0
      temp.each do |line|
        res = line.scan(pattern)
        # puts "line #{line} gave #{res}"
          if !res.empty?
            # puts "yayyyy"
            num_lines += 1
          end
      end
      result_output = num_lines
    elsif options[:m_flag]
      res = fileContents.scan(pattern)
      res.each do |e|
        result_output << e + "\n"
      end
    else
      temp = fileContents.split("\n")
      temp.each do |line|
        res = line.scan(pattern)
        # puts "line #{line} gave #{res}"
          if !res.empty?
            # puts "yayyyy"
            result_output << line + "\n"
          end
      end
    end
  end

  puts result_output
end

if __FILE__ == $0
  run
end
