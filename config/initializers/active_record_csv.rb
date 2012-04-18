module ActiveRecordCSV
    def self.included(base)
      base.extend(ClassMethods)
    end

    # add your instance methods here
		def to_csv
			attributes.values.join(", ")
		end

    module ClassMethods
      # add your static(class) methods here
			def csv_header
				attribute_names.join(", ")
			end
   end
 end

 # include the extension 
 ActiveRecord::Base.send(:include, ActiveRecordCSV)