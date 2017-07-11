class PassengerMailer < ApplicationMailer
  default from: 'flightbooker@mail.com'

  def thankyou_email(passenger)
    @passenger = passenger
    mail(to: @passenger.email, subject: "Thank you for booking your flight")
  end


end
