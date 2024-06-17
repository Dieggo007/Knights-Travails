# frozen_string_literal: true
require_relative 'lib/knight_node'

shortest_path = find_shortest_path([3, 3], [4, 3])
puts "You made it in #{shortest_path.length - 1} moves! Here's your path: "
shortest_path.each { |step| puts "[#{step[0]},#{step[1]}]" }


