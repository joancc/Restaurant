class ReservationMailer < ActionMailer::Base
  default from: "from@email.com"

  def reservation_notification(user, reservation)
    @reservation = reservation
    p "In ReservationMailer. User: #{user.name}, #{user.email}"
    mail(to: "#{user.name} <#{user.email}>", subject: "Reservation confirmation")

  end
end
