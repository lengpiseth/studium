
# Modify the CSV application to support an each method to return a
# CsvRow object. Use method_missing on that CsvRow to return the value
# for the column for a given heading.
module ActsAsCsv

  def self.included(base)
    base.extend ClassMethods
  end
  
  module ClassMethods
    def acts_as_csv
      include InstanceMethods
    end
  end
  
  module InstanceMethods   
    def read
      @csv_contents = []
      filename = self.class.to_s.downcase + '.txt'
      file = File.new(filename)
      @headers = file.gets.chomp.split(', ')

      file.each do |row|
        @csv_contents << row.chomp.split(', ')
      end
    end

    def each(&block)
      csv_contents.each do |contents|
        block.call(CsvRow.new(headers, contents))
      end
    end
    
    attr_accessor :headers, :csv_contents

    def initialize
      read 
    end    
  end

end

class CsvRow
  attr_accessor :headers, :contents

  def initialize(headers, contents)
    @headers = headers
    @contents = contents
  end

  def method_missing(name, *args)
    column = headers.index(name.to_s)
    contents[column]
  end
end

class RubyCsv
  include ActsAsCsv
  acts_as_csv
end

csv = RubyCsv.new
csv.each { |row| puts row.one }
