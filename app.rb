require_relative 'map'
require_relative 'map_drawer'

map = Map.new
map_builder = MapDrawer.new(map)
puts "Map with start and end positions\n"
map_builder.draw
puts "\nMap with path calculation\n"
map_builder.draw_path
