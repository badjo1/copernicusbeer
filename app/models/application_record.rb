require 'csv'

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.generate_csv(attributes)
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |record|
        csv << attributes.map{ |attr| record.send(attr) }
      end
    end
  end

end
