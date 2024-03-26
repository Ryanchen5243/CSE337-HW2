require 'set'
def contain_virus(grid)
  # find first infected cell
  ind_x = -1
  ind_y = -1
  found = false
  grid.each_with_index do |row, i|
    break if found
    row.each_with_index do |element, j|
        if element == 1
        ind_x = i
        ind_y = j
        found = true
        break
      end
    end
  end
  # puts "starting idex is x = #{ind_x} y = #{ind_y}"
  visited = Set.new # keep track of visited cells

  total_walls = 0
  # perform bfs operation to count walls
  queue = [[ind_x,ind_y]]

  while !queue.empty?
    n = queue.shift
    left = [n[0]-1, n[1]]
    up = [n[0], n[1]+1]
    right = [n[0]+1, n[1]]
    down = [n[0], n[1]-1]
    [left,up,right,down].each do |neighbor|
      # puts "neighbor is #{neighbor}"

      # check for out of bounds
      out_of_bounds = neighbor[0] < 0 || neighbor[0] >= grid.size || neighbor[1] < 0 || neighbor[1] >= grid[0].size
      if out_of_bounds
        # puts "outside bounds"
        total_walls += 1
      else
        # puts 'within bounds'
        # if neighbor not visited
        if (!visited.include?(neighbor))
          neighbor_value = grid[neighbor[0]][neighbor[1]]
          # p "neighbor is #{neighbor} and has value #{neighbor_value}"
          if neighbor_value == 0 # not infected
            # puts "not infected"
            total_walls += 1
          else # infected
            # puts "infected"
            if !queue.include?(neighbor)
              queue.push(neighbor)
            end
          end
        end
      end
    end
    # mark node visited
    visited.add(n)
  end

  total_walls
end


if __FILE__ == $0
  # res = contain_virus([[0,1,1,0],[0,0,1,0],[0,1,1,0],[0,1,0,0]])
  # expected output is 14
  #
  isInfected = [[0,1,0,0],[1,1,1,0],[0,1,0,0],[1,1,0,0]]
  # Call the function and store the result in a variable
  result = contain_virus(isInfected)
  # Print the result
  puts "Number of walls needed: #{result}"

end
