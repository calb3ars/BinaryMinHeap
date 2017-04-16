require "byebug"
class BinaryMinHeap
  def initialize(&prc)
    @store = []
    @len = @store.length
  end

  def count
    @store.length - 1
  end

  def extract
    BinaryMinHeap.swap(@store,0, count)
    # min = @store.last
    if count > 1
      BinaryMinHeap.heapify_down(@store, 0, count)
    end
    @store.pop
  end

  def peek
    @store[0]
  end

  def push(val)
    @store << val
    BinaryMinHeap.heapify_up(@store, @len)
  end

  protected
  attr_accessor :prc, :store

  public
  def self.child_indices(len, parent_index)
    children = []
    children << parent_index * 2 + 1 unless parent_index * 2 + 1 > len - 1
    children << parent_index * 2 + 2 unless parent_index * 2 + 2 > len - 1
    children
  end

  def self.parent_index(child_index)
    raise "root has no parent" unless child_index > 0
    ( child_index - 1 ) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    i = 0
    prc ||= Proc.new {|a,b| a <=> b}
    while i <= parent_index(len - 1)
      children = child_indices(len, i)
      if children.length > 1
        smallest_child = prc.call(array[children[0]], array[children[1]]) == -1 ? children[0] : children[1]
      else
        smallest_child = children[0]
      end
      # smallest_child = child_indices(len, i).min_by {|idx| array[idx]}
      if prc.call(array[i], array[smallest_child]) == 1
        swap(array, i, smallest_child)
        i = smallest_child
      else
        break
      end
    end
    array
  end

  def self.swap(arr, idx_1, idx_2)
    arr[idx_1], arr[idx_2] = arr[idx_2], arr[idx_1]
    arr
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new {|a,b| a <=> b}
    i = len - 1
    while i > 0
      current = array[i]
      parent = array[parent_index(i)]
      if prc.call(current, parent) == -1
        swap(array, i, parent_index(i))
        i = parent_index(i)
      else
        break
      end
    end
    return array
  end
end
