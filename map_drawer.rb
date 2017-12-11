require_relative 'map'
# map
class MapDrawer
  def initialize(map)
    @map = map.map
  end

  def draw
    map_out = @map
    map_out.map { |elem| puts "#{elem.join(' ')}\n" }
  end

  def draw_path
    Map.new.way.map { |el| @map[el[0]][el[1]] = el[2] }
    @map.map { |elem| puts "#{elem.join(' ')}\n" }
  end
end
