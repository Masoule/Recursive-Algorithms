require 'byebug'
def range(first, last)
  return [] if first > last
  return [first] if first == last - 1
  [first] + range(first+1, last)
end

def rec_sum_of_array(arr)
  return nil if arr.empty?
  return arr[0] if arr.length == 1
  arr[0] + rec_sum_of_array(arr[1..-1])
end

def iterative_sum(arr)
  arr.reduce(:+)
end

def exp(n, p)
 return 1 if p ==0
 n * exp(n, p-1)
end

def exp2(n, p)
  return 1 if p == 0
  return n if p == 1
  p.even? ? exp2(n,p/2) * exp2(n,p/2) : n * exp2(n, (p-1)/2 * exp2(n, (p-1)/2))
end

class Array

  def deep_dup
    result = []
    self.each do |el|
      if !el.is_a?(Array)
        result << el
      else
        result << el.deep_dup
      end
    end
    result
  end

end

def fib(n)
  [0, 1].take(n) if n <= 2
  fibs = fib(n-1)
  fibs << fibs[-1] + fibs[-2]
end

def fib_it(n)
  fibs = [0,1].take(n)
  until fibs.length == n
    fibs << fibs[-1] + fibs[-2]
  end
  fibs
end

def subsets(arr)
  return [[]] if arr.empty?
  dropped = [arr[-1]]
  subs = subsets(arr[0...-1])
  subs_with_dropped = subs.map { |s| s + dropped }
  subs + subs_with_dropped
end

def permutations(arr)
  # debugger
  return [arr] if arr.size == 1
  perms = []
  arr.each_with_index do |el, i|
    remaining = arr[0...i] + arr[i+1..-1]
    this_perms = permutations(remaining).map do |perm|
      perm.unshift(el)
    end
    perms += this_perms
  end
  perms.uniq #if array has duplicates we don't want the same perm to appear twice
end

def bsearch(arr, target)
  idx = arr.size/2 #target index
  return idx if target == arr[idx]
  return nil if arr[idx].nil?
  if target < arr[idx]
    bsearch(arr[0...idx], target)
  else
    new_search = bsearch(arr[idx + 1..-1], target)
    return nil if new_search.nil?
    idx + new_search + 1
  end
end

def merge_sort(arr)
  return arr if arr.size <= 1
  left = merge_sort(arr.take(arr.size/2))
  right = merge_sort(arr.drop(arr.size/2))
  merge(left, right)
end

def merge(arr1,arr2)
  merged = []
  until arr1.empty? || arr2.empty?
    arr1[0] < arr2[0] ? merged << arr1.shift : merged << arr2.shift
  end
  arr1.empty? ? merged.concat(arr2) : merged.concat(arr1)
end

def greedy_make_change(amount, coins = [25,10,5,1])
  coins = coins.sort
  return [] if coins.empty? || amount < coins.first
  result = []
  biggest = coins.pop
  num_coins = amount / biggest
  remaining = amount % biggest
  num_coins.times {result << biggest}
  result + greedy_make_change(remaining,coins)
end

def make_better_change(amount, coins = [25,10,5,1], i=0)
  remainder = amount - coins.max
  result = [[]]
  subresult = [[]]
  return [] if coins.empty?
  coins.each_with_index do |coin, idx|
    return [] if amount < coin || (coins.length == 1 && remainder < 0)
    subresult[idx] << coin
    p "coin #{coin}"
    p i += 1
    coins = coins.select {|c| c <= coin }
    p subresult[idx] += make_better_change(remainder, coins, i)
  end
  result[i] += subresult
  p "result: #{result}"
end
