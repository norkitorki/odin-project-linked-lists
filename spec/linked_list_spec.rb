require_relative '../lib/linked_list'

describe LinkedList do
  List = LinkedList.new

  context 'Node' do
    it 'should initialize with a value as well as an optional next node' do
      successor = LinkedList::Node.new(200)
      node = LinkedList::Node.new(100, successor)
      expect(node.value).to eq(100)
      expect(node.next).to eq(successor)
    end
  end

  it 'should initialize with a size of 0' do
    expect(List.size).to eq(0)
  end

  it 'should have head and tail reader methods' do
    expect(List.respond_to?(:head)).to eq(true)
    expect(List.respond_to?(:tail)).to eq(true)
  end

  context 'append' do
    it 'should append a node' do
      List.append('hello')
      List.append('world')
      expect(List.head.value).to eq('hello')
      expect(List.tail.value).to eq('world')
    end
  end

  context 'prepend' do
    it 'should prepend a node' do
      List.prepend([2, 3, 5, 8])
      expect(List.head.value).to eq([2, 3, 5, 8])
    end
  end

  context 'at' do
    it 'should return a node at a specific index' do
      node = List.at(1)
      expect(node.class).to eq(LinkedList::Node)
      expect(node.value).to eq('hello')
    end
  end

  context 'contains?' do
    it 'should return whether a node exists' do
      expect(List.contains?('world')).to eq(true)
      expect(List.contains?(100)).to eq(false)
    end
  end

  context 'find' do
    it 'should return the index of a node' do
      expect(List.find([2, 3, 5, 8])).to eq(0)
      expect(List.find('String')).to eq(nil)
    end
  end

  context 'pop' do
    it 'should remove the last node' do
      List.pop
      expect(List.size).to eq(2)
      expect(List.tail.value).to eq('hello')
    end

    it 'should raise an IndexError if list is empty' do
      list = LinkedList.new
      expect { list.pop }.to raise_error(IndexError)
    end
  end

  context 'to_s' do
    it 'should print the list' do
      expect(List.to_s).to eq(' -> ( [2, 3, 5, 8] ) -> ( hello )')
    end
  end

  context 'insert_at' do
    it 'should insert a node at the given index' do
      previous_node = List.at(1)
      List.insert_at(100, 1)
      expect(List.at(1).value).to eq(100)
      expect(List.at(1).next).to eq(previous_node)
    end

    it 'should insert a node even if index is out of range' do
      previous_tail = List.tail
      List.insert_at(5000, 5000)
      expect(List.tail.value).to eq(5000)
      expect(previous_tail.next.value).to eq(5000)

      previous_head = List.head
      List.insert_at({ foo: :bar }, -200)
      expect(List.head.value).to eq({ foo: :bar })
      expect(List.head.next).to eq(previous_head)
    end
  end

  context 'remove_at' do
    it 'should remove a node at the given index' do
      removed_node = List.at(1)
      List.remove_at(1)
      expect(List.contains?(removed_node.value)).to eq(false)
      expect(List.head.next).to eq(removed_node.next)
    end

    it 'should raise an IndexError if the index is not in range' do
      expect { List.remove_at(-1) }.to raise_error(IndexError)
      expect { List.remove_at(24) }.to raise_error(IndexError)
    end
  end
end
