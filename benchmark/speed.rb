#!/usr/bin/env ruby

require 'benchmark'
require File.expand_path('../../lib/pearson-hashing', __FILE__)

Benchmark.bm do |b|
  b.report 'PearsonHashing#digest8' do
    100_000.times do |i|
      PearsonHashing.digest8 i.to_s
    end
  end
  
  b.report 'PearsonHashing#digest16' do
    100_000.times do |i|
      PearsonHashing.digest16 i.to_s
    end
  end
  
  b.report 'String#hash' do
    100_000.times do |i|
      i.to_s.hash
    end
  end
end
