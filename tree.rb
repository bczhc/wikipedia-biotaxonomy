require_relative 'lib'

ValueType = Taxon

class Node
  attr_accessor :value, :children

  def initialize(value, children)
    @value = value
    @children = children
  end

  # @param value [ValueType]
  def find_node(value)
    if @value == value
      return self
    end

    @children.each do |n|
      result = n.find_node value
      return result if result != nil
    end
    nil
  end

  # @param new_value [Taxon]
  # @param child [Node]
  def insert_node(new_value, child)
    find = find_node new_value
    if find != nil
      find.children.push(child)
      return find
    end
    nil
  end

  # @param lineage [Array<Taxon>]
  def self.from_lineage(lineage)
    fail 'Lineage is empty' if lineage.empty?
    node = Node.new lineage.last, []
    lineage.reverse.drop(1).each do |taxon|
      node = Node.new taxon, [node]
    end
    node
  end

  # @param lineage [Array<Taxon>]
  def insert_lineage(lineage)
    found = nil

    (0...lineage.length).reverse_each do |i|
      node = find_node lineage[i]
      if node != nil
        found = { index: i, node: node }
        break
      end
    end

    fail "Lineage doesn't have an intersection with the main tree" if found == nil

    subtree = Node.from_lineage lineage[(found[:index] + 1)...]
    found[:node].children.push(subtree)
  end

  # @param depth [Integer]
  def print_tree(depth)
    indentation = '  ' * depth
    if depth == 0
      puts "#{indentation}<#{@value}>"
    end
    @children.each do |c|
      puts "#{indentation}  #{c.value}"
      c.print_tree depth + 1
    end
  end
end

class Tree
  attr_accessor :root

  def initialize
    @root = nil
  end

  # @param lineage [Array<Taxon>]
  def add_lineage(lineage)
    if @root == nil
      @root = Node.new(lineage[0], [])
    end
    @root.insert_lineage lineage
  end
end