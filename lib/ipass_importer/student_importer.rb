require 'csv'
module StudentImporter
  def self.import(file_path, school)
    CSV.foreach(file_path, :headers => true) do |row|
      row_hash = row.to_hash
      counselor_last_name = row_hash.delete('Counselor')
      counselor = Conselor.find_by_last_name counselor_last_name
      new_student = Student.new row_hash
      new_student.counselor = counselor
      new_student.save
    end
  end
end