require 'spec_helper'

describe PearsonHashing do
  describe '#digest' do
    it 'should return 96 for "foo"' do
      PearsonHashing.digest('foo').should == 96
    end
  end
end
