class Catalogs::Supplier < ActiveRecord::Base
include Searchable

has_many :Contracts
validates :business_name, uniqueness: true, presence: true
validates :contact, :phone, :email, :phone_office, presence: true

def short_name(length=18)
	business_name.truncate(length)
end
end
