class System::Contract < ActiveRecord::Base
	require 'Google_Calendar'
	include Google_Calendar
	
  require 'Delayed_Calendar'
include Delayed_Calendar
  
belongs_to :device, :class_name => 'Catalogs::Device', :foreign_key => 'device_id'
belongs_to :supplier, :class_name => 'Catalogs::Supplier', :foreign_key => 'supplier_id'
has_many :Renewals, dependent: :destroy
validates :device_id, :supplier_id, :description ,presence: true
validates :contract_no, uniqueness: true

attr_accessor :start_date
attr_accessor :end_date
attr_accessor :monto

def short_name(length=18)
	contract_no.truncate(length)
end

end
