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
    end
  end
end
