class System::Renewal < ActiveRecord::Base
require 'Google_Calendar'
include Google_Calendar

require 'Delayed_Calendar'
include Delayed_Calendar
  
has_many :Siteviews, dependent: :destroy
belongs_to :contract, :class_name => 'System::Contract', :foreign_key => 'contract_id'
validates :start_date, :end_date, :monto, presence: true

  def stat
        if Time.now >= start_date and Time.now <= end_date
          :active
        else
          :finished
        end
  end

  def vigencia
  	if end_date.between?(Time.now,Time.now+30.days)
  		:to_expire
  	elsif end_date > Time.now+31.days
  		:active
  	elsif end_date < Time.now
  		:finished
  	end
  end

  def date_filter(startDate, endDate)
   # if start_date >= startDate or end_date <= endDate
    #  :active
    #end
    if startDate >= start_date and startDate <= end_date
      :active
    elsif endDate <= end_date and endDate >= start_date
      :active        
    end
  end

  
end
