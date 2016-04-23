# title:string
# description:text
# start_date:date
# end_date:date
# repeat_day:integer
# repeat_each_days:integer
# repeat_each_months:integer
require 'time'

class Event < ActiveRecord::Base
  def occurs_on_date?(date)
    return date === self.get_next_occurrence(date)
  end

  def get_next_occurrence(date)
    return nil if self.start_date.nil?
    return nil if (not self.end_date.nil?) and self.end_date < date
    
    if self.repeat_day > 0
      if self.repeat_day < date.mday
        date = date + days_in_month(date)
      end
      
      date = date - date.mday
      date = date + self.repeat_day
      
      return date
    elsif self.repeat_each_days > 0
      start = self.start_date
      
      while start < date
        start = start + self.repeat_each_days
      end
      
      return start
    elsif self.repeat_each_months > 0
      start = self.start_date
      
      while start < date
        start = start + days_in_month(start)
      end
      
      return start
    else
      return nil
    end    
  end
  
  def days_in_month(date)
    return date.to_time.end_of_month.day
  end
end
