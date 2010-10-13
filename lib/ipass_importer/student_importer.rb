require 'csv'
module StudentImporter
  def self.import
    CSV.foreach("/Users/dseaver86/Downloads/ducky_export.csv", :headers => true) do |row|
      row_hash = row.to_hash
      row_hash.delete('Counselor')
      new_student = Student.new row_hash
      new_student.save
    end
  end
end