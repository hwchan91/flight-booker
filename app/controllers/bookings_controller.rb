class BookingsController < ApplicationController
  :after_validation

  def new
    flight = Flight.find(params[:flight_id])
    seats = params[:seats].to_i
    @booking = flight.bookings.build
    seats.times do
      @booking.passengers.build
    end
  end

  def create
    flight = Flight.find(params[:booking][:flight_id])
    @booking = flight.bookings.build(booking_params)
    if @booking.save
      redirect_to @booking
    else
      render 'new'
    end
  end

  def show
    @booking = Booking.find(params[:id])
  end

  private
    def booking_params
      params.require(:booking).permit(passengers_attributes: [:name, :email])
    end

end
