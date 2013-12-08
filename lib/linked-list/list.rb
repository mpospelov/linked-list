module LinkedList
  class List
    include Conversions

    attr_reader  :length
    alias_method :size, :length

    def initialize
      @head   = nil
      @tail   = nil
      @length = 0
    end

    # Returns the first element of the list or nil.
    #
    def first
      @head && @head.data
    end

    # Returns the last element of the list or nil.
    #
    def last
      @tail && @tail.data
    end

    # Pushes new nodes to the end of the list.
    #
    # == Parameters:
    # node:: Any object, including +Node+ objects.
    #
    # == Returns:
    # self of +List+ object.
    #
    def push(node)
      node = Node(node)
      @head ||= node

      @tail.next = node if @tail
      @tail = node

      @length += 1
      self
    end
    alias_method :<<, :push

    # Pushes new nodes on top of the list.
    #
    # == Parameters:
    # node:: Any object, including +Node+ objects.
    #
    # == Returns:
    # self of +List+ object.
    #
    def unshift(node)
      node = Node(node)
      @tail ||= node

      node.next = @head
      @head = node

      @length += 1
      self
    end

    # Removes node from the end of the list.
    #
    # == Returns:
    # Data stored in the node or nil.
    #
    def pop
      return nil unless @head

      node = @head
      next_to_tail = nil
      while(node = node.next)
        next_to_tail = node unless node.next
      end
      @head = nil unless next_to_tail

      tail = @tail
      @tail = next_to_tail

      @length -= 1
      tail.data
    end

    # Removes node from the beginning of the list.
    #
    # == Returns:
    # Data stored in the node or nil.
    #
    def shift
      return nil unless @head

      head = __shift
      @tail = nil unless @head

      @length -= 1
      head.data
    end

    # Reverses list of nodes in place.
    #
    # == Returns:
    # self in reverse order.
    #
    def reverse!
      return self unless @head

      prev_node = __shift
      prev_node.next = nil
      @tail = prev_node

      while(@head)
        curr_node = __shift
        curr_node.next = prev_node
        prev_node = curr_node
      end
      @head = prev_node
      self
    end

    # Iterates over nodes from top to bottom passing node data to the block if
    # given. If no block given, returns +Enumerator+.
    #
    # == Returns:
    # +Enumerator+ or yields data to the block stored in every node on the
    # list.
    #
    def each
      return to_enum(__callee__) unless block_given?
      __each { |e| yield(e.data) }
    end

    # Conversion function, see +Conversions.List+.
    #
    # == Returns:
    # self
    #
    def to_list
      self
    end

    private

    def __shift
      head = @head
      @head = @head.next
      head
    end

    def __each
      next_node = @head
      while(next_node)
        yield next_node
        next_node = next_node.next
      end
    end
  end
end