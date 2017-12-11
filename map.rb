# Class for map realization and path finding
class Map
  attr_reader :map
  def initialize
    @map = read_map
  end

  def read_map
    map = IO.read('map.txt').split("\n")
    map.map { |line| line.split('') }
  end

  def start_point_x
    start_point_x = @map.map { |longitude| longitude.index '0' }
    start_point_x.join.to_i
  end

  def start_point_y
    index = 0
    @map.map do |latitude|
      index = latitude if latitude.any? { |elem| elem == '0' }
    end
    start_point_y = @map.index index
    start_point_y
  end

  def end_point_y
    index = nil
    @map.map do |latitude|
      index = latitude if latitude.any? { |elem| elem == 'x' }
    end
    end_point_y = @map.index index
    end_point_y
  end

  def end_point_x
    end_point_x = @map.map { |longitude| longitude.index 'x' }
    end_point_x.join.to_i
  end

  def find_path
    count = 0
    end_x = end_point_x
    end_y = end_point_y.to_i
    @map[start_point_y.to_i][start_point_x] = count
    while @map[end_y][end_x] == 'x'
      wave(count, 0)
      count += 1
    end
  end

  def way
    end_x = end_point_x
    end_y = end_point_y.to_i
    find_path
    puts "The shortest way = #{@map[end_y][end_x]} steps\n"
    back_way_step(end_x, end_y)
  end

  private

  def wave(count, y)
    until y >= 10
      x = 0
      until x >= 10
        neighbors(x, y, count)
        x += 1
      end
      y += 1
    end
  end

  def neighbors(x, y, count)
    @map[x][y - 1] = count + 1 if up?(x, y, count)
    @map[x][y + 1] = count + 1 if down?(x, y, count)
    @map[x - 1][y] = count + 1 if left?(x, y, count)
    @map[x + 1][y] = count + 1 if right?(x, y, count)
  end

  def back_way_step(end_x, end_y)
    back_way = []
    until (@map[end_y][end_x]).zero?
      back_way << [end_y, end_x, @map[end_y][end_x]]
      if back_way_up?(end_x, end_y)
        end_y -= 1
      elsif back_way_left?(end_x, end_y)
        end_x -= 1
      elsif back_way_right?(end_x, end_y)
        end_x += 1
      elsif back_way_down?(end_x, end_y)
        end_y += 1
      end
    end
    back_way
  end

  def down?(x, y, count)
    y < 9 && @map[x][y + 1] != 's' && @map[x][y + 1].is_a?(String) &&
      @map[x][y] == count
  end

  def up?(x, y, count)
    y.positive? && @map[x][y - 1] != 's' && @map[x][y - 1].is_a?(String) &&
      @map[x][y] == count
  end

  def left?(x, y, count)
    x.positive? && @map[x - 1][y] != 's' && @map[x - 1][y].is_a?(String) &&
      @map[x][y] == count
  end

  def right?(x, y, count)
    x < 9 && @map[x + 1][y] != 's' && @map[x + 1][y].is_a?(String) &&
      @map[x][y] == count
  end

  def back_way_up?(end_x, end_y)
    @map[end_y - 1][end_x].is_a?(Integer) &&
      @map[end_y][end_x] - @map[end_y - 1][end_x] == 1
  end

  def back_way_left?(end_x, end_y)
    @map[end_y][end_x - 1].is_a?(Integer) &&
      @map[end_y][end_x] - @map[end_y][end_x - 1] == 1
  end

  def back_way_right?(end_x, end_y)
    @map[end_y][end_x + 1].is_a?(Integer) &&
      @map[end_y][end_x] - @map[end_y][end_x + 1] == 1
  end

  def back_way_down?(end_x, end_y)
    @map[end_y + 1][end_x].is_a?(Integer) &&
      @map[end_y][end_x] - @map[end_y + 1][end_x] == 1
  end
end
