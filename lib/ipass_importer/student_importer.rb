require 'csv'
module StudentImporter
  def self.import(file_path, school)
    CSV.foreach(file_path, :headers => true) do |row|
      
      guardians = []
      guardian_first_name = row.delete('GuardianFirst Name')
      guardian_last_name = row.delete('GuardianLast Name')
      
      while(!guardian_first_name.empty?) do
        unless guardian_first_name.last.nil?
          guardian = Guardian.new
          guardian.first_name = guardian_first_name.last
          guardian.last_name = guardian_last_name.last
          guardians.push guardian
        end
        
        guardian_first_name = row.delete('GuardianFirst Name')
        guardian_last_name = row.delete('GuardianLast Name')
      end
      row_hash = row.to_hash
      student_id = row_hash['student_id']
      counselor_last_name = row_hash.delete('Counselor').split(' ').first
      counselor = school.counselors.find_by_last_name counselor_last_name
      row_hash['counselor_id'] = counselor.id
      student = Student.find_by_student_id student_id

      if student
        student.update_attributes row_hash
        guardians.each do |g|
          if student.guardians.where('first_name = ? AND last_name = ?', g.first_name, g.last_name).empty?
            student.guardians<<g
          end
        end
        student.save
      else
        new_student = Student.new row_hash
        new_student.school = school
        new_student.guardians = guardians
        new_student.save
      end
    end
  end
end