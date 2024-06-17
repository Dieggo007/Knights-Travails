# frozen_string_literal: true

class KnightNode

  attr_accessor :possible_squares, :visited, :previous_node

  def initialize(position_x, position_y)
    @position_x = position_x
    @position_y = position_y
    @visited = false
    @possible_squares = []
    @previous_node = nil
  end

  def define_movements(board)
    variations = [1, 2, -1, -2, 1, -2, -1, 2, 1]
    # (1, 2), (2, -1), (-1, -2), (-2, 1), (1, -2), (-2, -1), (-1, 2), (2, 1)
    8.times do |i|
      next_x = @position_x + variations[i]
      next_y = @position_y + variations[i + 1]
      @possible_squares.push(board[next_x][next_y]) if next_x >= 0 && next_x < 8 && next_y >= 0 && next_y < 8
    end
  end

  def square
    [@position_x, @position_y]
  end

  def reconstruct_path()
    return [square] if @previous_node.nil?

    [*@previous_node.reconstruct_path, square]
  end

end

@board = Array.new(8) { Array.new(8) }

@board.each_with_index do |_, i|
  @board[0].each_with_index do |_, j|
    @board[i][j] = KnightNode.new(i, j)
  end
end

@board.each do |row|
  row.each do |square|
    square.define_movements(@board)
  end
end

def find_shortest_path(start_node, end_node)
  queue = []
  queue.push(@board[start_node[0]][start_node[1]])
  until queue.empty?
    current = queue.shift
    return current.reconstruct_path if current == @board[end_node[0]][end_node[1]]

    current.visited = true
    queue.push(*current.possible_squares.filter do |node|
      unless node.visited
        node.previous_node = current
        true
      end
    end)
  end
end


