
require 'spec_helper'

describe Note do
  subject { create(:counselor, :school => create(:school)).notes.build }
  it { should     have_valid(:duration).when('', nil, 1, 10) }
  it { should_not have_valid(:duration).when('a', -10, 1.5) }
end
