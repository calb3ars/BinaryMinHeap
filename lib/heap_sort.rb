require_relative "heap"

class Array
  def heap_sort!
    heap = BinaryMinHeap.new
    self.each do |el|
      heap.push(el)
      
    end
    self.each_with_index do |el, i|
      self[i] = heap.extract
    end
  end
end
