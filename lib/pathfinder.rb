# lib/pathfinder.rb
# frozen_string_literal: false

# The `PathFinder` module uses graph functions.
# gets the movement of a piece and a desired position then find the path
# to the targeted position.
module PathFinder
  def find_path(pos, new_pos)
    graph = Graph.new(pos) { |node| find_valid_moves(node.data) }

    path = []
    path << new_pos
    path << graph.get_parent(path.last).data until graph.get_parent(path.last).nil?
    path.reverse
  end

  # Graph class and find methods
  class Graph
    attr_accessor :root

    def initialize(pos, &find_childs)
      @root = Node.new(pos)
      build_graph(&find_childs) if block_given?
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

    def preorder(node = @root, &operation)
      return if node.nil?

      operation.call(node)
      node.childs.each { |child| preorder(child, &operation) }
    end

    def get_parent(data)
      return nil if data == @root.data

      preorder do |node|
        node.childs.each { |child| return node if !child.nil? && child.data == data }
      end
    end

    def build_graph(&find_positions)
      visited = [root.data]
      level_order do |node|
        return if node.nil?

        positions = calculate_childs(node, visited, &find_positions)
        positions.each { |position| node.childs << Node.new(position) }
      end
    end

    private

    def calculate_childs(node, visited, &find_positions)
      positions = find_positions.call(node)
      visited.each do |visited_pos|
        positions = positions.reject { |posible_move| posible_move == visited_pos }
      end
      visited.push(*positions)
      positions
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
