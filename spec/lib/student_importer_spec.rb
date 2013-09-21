require 'spec_helper'
require 'student_importer'

describe StudentImporter do
  describe '.import' do
    let(:school) { create :school }
    let!(:counselor) { create :counselor, last_name: 'Counselor', school: school }
    let!(:student_updated) { create :student, student_id: '12345', counselor: counselor, school: school }
    let!(:student_inactive) { create :student, student_id: '12344', counselor: counselor, school: school }
    before { StudentImporter.import("#{Rails.root}/spec/support/export.csv", school) }

    it 'updates existing students' do
      student_updated.reload
      student_updated.first_name.should eq 'Test'
      student_updated.last_name.should eq 'Student'
      student_updated.primary_phone_number.should eq '508-555-5555'
      student_updated.city.should eq 'Marshfield'
      student_updated.year_of_graduation.should eq 2013
      student_updated.shop.should eq 'Carpentry'
      student_updated.counselor_id.should eq counselor.id
      student_updated.active.should be_true
    end

    it 'marks students missing from the CSV as inactive' do
      student_inactive.reload
      student_inactive.active.should be_false
    end

    it 'adds students from the CSV' do
      student = school.students.find_by_student_id '12346'

      student.first_name.should eq 'Test'
      student.last_name.should eq 'New'
      student.primary_phone_number.should eq '508-555-5555'
      student.city.should eq 'Marshfield'
      student.year_of_graduation.should eq 2013
      student.shop.should eq 'Carpentry'
      student.counselor_id.should eq counselor.id
      student.active.should be_true
    end
  end
end
