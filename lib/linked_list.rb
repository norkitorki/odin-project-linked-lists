# frozen_string_literal: true

# singly linked List class
class LinkedList
  attr_reader :head, :tail, :size

  # linked List node class
  class Node
    attr_accessor :value, :next

    def initialize(value, successor = nil)
      @value = value
      @next  = successor
    end
  end

  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def append(value)
    insert_at(value, size)
  end

  def prepend(value)
    insert_at(value, 0)
  end

  def at(index)
    iterate(index)
  end

  def pop
    remove_at(size - 1)
  end

  def contains?(value)
    iterate { |node| return true if node.value == value }
    false
  end

  def find(value)
    iterate { |node, i| return i if node.value == value }
  end

  def to_s
    output = String.new
    iterate { |node| output << " -> ( #{node.value} )" }
    output
  end

  def insert_at(value, index)
    if head.nil? || index <= 0
      @head = Node.new(value, head)
    elsif index >= size
      tail.next = Node.new(value)
    else
      predecessor = iterate(index - 1)
      predecessor.next = Node.new(value, predecessor.next)
    end
    update_tail
    @size += 1
  end

  def remove_at(index)
    raise IndexError, 'index out of range' unless index.between?(0, size - 1)

    if index.zero?
      @head = head&.next
    else
      predecessor = iterate(index - 1)
      predecessor.next = predecessor.next.next
    end
    update_tail(size - 2)
    @size -= 1
  end

  private

  def iterate(index = size)
    node = head
    i = 0
    while node && i < index
      yield node, i if block_given?
      node = node.next
      i += 1
    end
    node
  end

  def update_tail(index = size)
    @tail = tail&.next || at(index)
  end
end
