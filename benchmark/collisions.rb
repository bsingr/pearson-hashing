#!/usr/bin/env ruby

require File.expand_path('../../lib/pearson-hashing', __FILE__)

SIZE = 512**2

def benchmark(name, &block)
  puts "#{name}.."
  hashes = {}
  SIZE.times do |i|
    hash = block.call(i.to_s)
    hashes[hash] ||= 0
    hashes[hash] = hashes[hash] + 1
  end
  
  # analysis
  collisions = hashes.inject(0){|coll,v| coll += (v[1]-1); coll}
  puts " => #{collisions} collisions per #{SIZE} (#{collisions/SIZE.to_f}%)"
end

benchmark 'PearsonHashing#digest8' do |str|
  PearsonHashing.digest8 str
end

benchmark 'PearsonHashing#digest16' do |str|
  PearsonHashing.digest16 str
end

benchmark 'PearsonHashing#digest32' do |str|
  PearsonHashing.digest32 str
end

benchmark 'String#hash' do |str|
  str.hash
end
