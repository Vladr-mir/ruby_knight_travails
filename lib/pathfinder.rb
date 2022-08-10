# lib/pathfinder.rb
# frozen_string_literal: false

# The `PathFinder` module uses graph functions.
# gets the movement of a piece and a desired position then find the path
# to the targeted position.
module PathFinder
  # Graph class and find methods
  class Graph; end

  # Node for graph
  class Node
    attr_accessor :data, :childs

    def initialize(data)
      @data = data
      @childs = []
    end
  end
end
