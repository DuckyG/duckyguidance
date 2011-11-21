require 'spec_helper'

describe User do
  describe '#formal_name' do
    it 'returns the user name in "Mr. Last" format' do
      user = FactoryGirl.build(:counselor, name_prefix: NamePrefix.new(prefix: 'Mr.'))

      user.formal_name.should eq('Mr. Test')
    end
  end

  describe '#full_name' do
    it 'returns the user name in "First Last" format' do
      user = FactoryGirl.build(:counselor)

      user.full_name.should eq('John Test')
    end
  end

  describe '#counselor?' do
    it "returns true when the user's role is 'counselor'" do
      user = FactoryGirl.build(:counselor)

      user.counselor?.should be_true
    end

    it "returns true when the user's role is 'director'" do
      user = FactoryGirl.build(:counselor, role: 'director')

      user.counselor?.should be_true
    end
  end

  describe '#director?' do
    it "returns false when the user's role is 'counselor'" do
      user = FactoryGirl.build(:counselor)

      user.director?.should be_false
    end

    it "returns true when the user's role is 'director'" do
      user = FactoryGirl.build(:counselor, role: 'director')

      user.director?.should be_true
    end
  end

end
