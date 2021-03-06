require_relative 'p02_hashing'

class HashSet
  attr_reader :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    unless include?(key)
      @count += 1
      resize! if count > num_buckets
      self[key] << key
      return true
    end
    false
  end

  def remove(key)
    self[key].delete(key)
  end

  def include?(key)
    self[key].include?(key)
  end


  private

  def [](key)
    index = key.hash % num_buckets
    @store[index]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    temp_store = HashSet.new(num_buckets*2)
    @store.flatten.each{|x|temp_store.insert(x)}
    @store = temp_store.store
  end
end
