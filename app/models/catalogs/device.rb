class Catalogs::Device < ActiveRecord::Base
has_many :Contracts
belongs_to :location, :class_name => 'Catalogs::Location', :foreign_key => 'location_id'
validates :name, :location_id, presence: true
validates :unam_stock_number, uniqueness: true, presence: true

def short_name(length=18)
	name.truncate(length)
end

end