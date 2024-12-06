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
  def insert_lineage(lineage)
    catch(:done) do
      while true
        (0...lineage.length).reverse_each do |i|
          found = find_node lineage[i]
          if found != nil
            throw :done if i + 1 >= lineage.length
            next_name = lineage[i + 1]
            found.children.push(Node.new(next_name, []))
            break
          end
        end
      end
    end
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