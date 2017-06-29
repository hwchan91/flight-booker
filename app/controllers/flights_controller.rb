class FlightsController < ApplicationController
  def index
    @airports = Airport.all.map{ |a| [a.code, a.id] }
    flight_dates = Flight.all.map{ |f| f.start_datetime.strftime("%Y-%m-%d") }.uniq.sort
    @flight_dates = flight_dates.each_with_index.map{|a, b| [a, b]}

    if !params[:flight].nil?
      @seats = params[:flight][:passengers]
      if @seats == ""
        flash[:danger] = "Choose number of passengers"
        render 'index'
      else
        from_airport_id = params[:flight][:from_airport_id]
        to_airport_id = params[:flight][:to_airport_id]
        start_date = params[:flight][:start_date]
        start_date = flight_dates[start_date.to_i] if start_date != ""
        matching_flights = Flight.all
        matching_flights = matching_flights.where(from_airport_id: from_airport_id) if from_airport_id != ""
        matching_flights = matching_flights.where(to_airport_id: to_airport_id) if to_airport_id != ""
        matching_flights = matching_flights.where("start_datetime LIKE ?", "#{start_date}%") if start_date != ""
        matching_flights = matching_flights.order(:from_airport_id, :to_airport_id, :start_datetime)
        @matching_flights = matching_flights
      end
    end
  end
end
