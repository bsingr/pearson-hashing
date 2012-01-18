require 'spec_helper'

describe PearsonHashing do
  describe '#digest' do
    it 'should return the same as #digest8' do
      PearsonHashing.digest('foo').should == PearsonHashing.digest8('foo')
    end
  end
  
  describe '#digest8' do
    it 'should return 96 for "foo"' do
      PearsonHashing.digest('foo').should == 96
    end
  end
  
  describe '#digest16' do
    it 'should return 96 for "foo"' do
      PearsonHashing.digest16('foo').should == 96099
    end
  end
  
  describe '#digest32' do
    it 'should return 96 for "foo"' do
      PearsonHashing.digest32('foo').should == 96099141
    end
  end
  
  describe '#digest_with_x_bytes' do
    it 'should equal #digest8 with 1 byte' do
      PearsonHashing.digest8('foo').should == \
        PearsonHashing.digest_with_x_bytes('foo', 1)
    end
    it 'should equal #digest16 with 2 byte' do
      PearsonHashing.digest16('foo').should == \
        PearsonHashing.digest_with_x_bytes('foo', 2)
    end
    it 'should equal #digest21 with 3 byte' do
      PearsonHashing.digest32('foo').should == \
        PearsonHashing.digest_with_x_bytes('foo', 3)
    end
  end
  
end
