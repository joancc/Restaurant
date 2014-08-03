class Reservation < ActiveRecord::Base
  belongs_to :restaurant

  validate :email, presence: true
  # validates_uniqueness_of :email
  validate :single_daily_reservation #Custom validator

  validate :time, presence: true
  validate :restaurant_id, presence: true

  def single_daily_reservation
    unless Reservation.where("date = ? AND email = ? AND restaurant_id = ?", Date.today, email, restaurant_id).empty?

      errors.add(:email, "You already have a reservation for today at this restaurant.")  #Fail the validation by adding an error to email
    end
  end

  def friendly_time
    min = (self.time.min==0) ? "00" : self.time.min
    "#{self.time.hour}:#{min}"
  end
end



