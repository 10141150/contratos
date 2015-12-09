class Catalogs::Location < ActiveRecord::Base
has_many :Devices
validates :department, :responsible, :email, presence: true

  def short_name(length=18)
	department.truncate(length)
  end
end