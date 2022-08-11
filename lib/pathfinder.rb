# lib/pathfinder.rb
# frozen_string_literal: false
require 'pry-byebug'

# The `PathFinder` module uses graph functions.
# gets the movement of a piece and a desired position then find the path
# to the targeted position.
module PathFinder
  def find_path(pos, new_pos)
    graph = Graph.new(pos)
    graph.build_graph { |node| find_valid_moves(node.data) }
    graph.level_order { |node| return node.data if node.data == new_pos }
  end

  # Graph class and find methods
  class Graph
    attr_accessor :root
    attr_reader :visited

    def initialize(pos)
      @root = Node.new(pos)
      @visited = [pos]
    end

    def level_order(node = @root, &operation)
      return if @root.nil?

      queue = [node]
      until queue.empty?
        current = queue[0]
        operation.call(current)
        current.childs.each { |child| queue << child }
        queue.shift
      end
    end

    def build_graph(node = @root, &find_positions)
      return if node.nil?

      positions = find_positions.call(node)
      @visited.uniq!
      @visited.each do |visited_pos|
        positions = positions.reject { |posible_move| posible_move == visited_pos }
      end
      return if positions.empty?

      positions.each do |position|
        @visited << node.data
        node.childs << Node.new(position)
      end

      node.childs.each do |child|
        build_graph(child, &find_positions)
      end
    end
  end

  # Node for graph
  class Node
    attr_accessor :data, :childs

    def initialize(data)
      @data = data
      @childs = []
    end
  end
end
