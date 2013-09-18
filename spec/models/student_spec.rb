require 'spec_helper'

describe Student do
  describe '.current' do
    let(:school) { create :school }
    let(:counselor) { create :counselor, school: school }
    let!(:joe_active_future) { create :student, counselor: counselor, school: school }
    let!(:joe_inactive_future) { create :student, counselor: counselor, school: school, active: false }
    let!(:joe_inactive_past) { create :student, counselor: counselor, school: school, active: false, year_of_graduation: 2010 }
    let!(:joe_active_past) { create :student, counselor: counselor, school: school, year_of_graduation: 2010 }

    let(:results) { school.students.current }

    it 'returns active students with a year of graduation in the future' do
      results.should include joe_active_future
    end

    it 'does not return inactive students with a year of graduation in the future' do
      results.should_not include joe_inactive_future
    end

    it 'does not return active students with a year of graduation in the past' do
      results.should_not include joe_active_past
    end

    it 'does not return inactive students with a year of graduation in the past' do
      results.should_not include joe_inactive_past
    end
  end
end
