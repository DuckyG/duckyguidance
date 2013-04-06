require 'spec_helper'

feature 'Creating a note', :js do
  scenario 'Valid note' do
    counselor = create(:counselor, :school => @school)
    category = create :category, :school => @school
    student = create(:student, :counselor => counselor, :school => @school)

    log_in_as counselor

    click_link 'Students'

    within student_row(student.full_name) do
      click_button 'View Student'
    end
    click_text 'Add a Note'

    within '#new_note' do
      select category.name, :from => 'Note Category'
      fill_in 'Note Summary', :with => 'Sample Note'

      fill_in 'Tags (separated by spaces)', :with => 'testing'
      fill_in 'Occurred On', :with => '2011-08-01'
      fill_in 'note_notes', :with => 'Note Contents'
      fill_in 'Duration', :with => 50

      click_button 'Add This Note'
    end

    within '.notesList' do
      page.should have_content category.name
      page.should have_content 'Sample Note'
      page.should have_content 'August 01 2011'
      page.should have_content 'Note Contents'
      click_link 'Sample Note'
    end

    page.should have_content '50 minutes'
  end
end
