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
    element_index = 0
    @map.each do |latitude|
      element_index = latitude if latitude.any? { |elem| elem == '0' }
    end
    start_point_y = @map.index element_index
    start_point_y
  end

  def end_point_y
    element_index = nil
    @map.each do |latitude|
      element_index = latitude if latitude.any? { |elem| elem == 'x' }
    end
    end_point_y = @map.index element_index
    end_point_y
  end

  def end_point_x
    end_point_x = @map.map { |longitude| longitude.index 'x' }
    end_point_x.join.to_i
  end

  def find_path
    step = 0
    @end_x = end_point_x
    @end_y = end_point_y.to_i
    start_x = start_point_x
    start_y = start_point_y.to_i
    integer_map
    @map[start_y][start_x] = step
    while @map[@end_y][@end_x] == -1
      wave(step, 0)
      step += 1
    end
  end

  def way
    find_path
    puts "The shortest way = #{@map[@end_y][@end_x]} steps\n"
    back_way_step(@end_x, @end_y)
  end

  private

  def integer_map
    @map = @map.map do |longitude|
    longitude.map do |element|
      element = element == 's' ? -2 : -1
      element
    end
    end
  end

  def wave(step, y)
    until y >= 10
      10.times { |x| neighbors(x, y, step)}
      y += 1
    end
  end

  def neighbors(x, y, step)
    @map[x][y - 1] = step + 1 if direction?(x, y, step, y - 1)
    @map[x][y + 1] = step + 1 if direction?(x, y, step, y + 1)
    @map[x - 1][y] = step + 1 if direction?(x, y, step, x - 1)
    @map[x + 1][y] = step + 1 if direction?(x, y, step, x + 1)
  end

  def back_way_step(end_c_x, end_c_y)
    end_x = end_c_x
    end_y = end_c_y
    back_way = []
    until (@map[end_y][end_x]).zero?
      back_way << [end_y, end_x, @map[end_y][end_x]]
      if back?(end_y - 1) && @map[end_y][end_x] - @map[end_y - 1][end_x] == 1
        end_y -= 1
      elsif back?(end_x - 1) && @map[end_y][end_x] - @map[end_y][end_x - 1] == 1
        end_x -= 1
      elsif back?(end_x + 1) && @map[end_y][end_x] - @map[end_y][end_x + 1] == 1
        end_x += 1
      elsif back?(end_y + 1) && @map[end_y][end_x] - @map[end_y + 1][end_x] == 1
        end_y += 1
      end
    end
    back_way
  end

  def direction?(x, y, step, direct)
    @map[x][y] == step && (0..9).cover?(direct) &&
      if direct == (y - 1) || direct == (y + 1)
        @map[x][direct] == -1
      elsif direct == (x + 1) || direct == (x - 1)
        @map[direct][y] == -1
      end
  end

  def back?(direct)
    (0..9).cover?(direct)
  end
end
