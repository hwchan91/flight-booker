airports = File.read("db/airports_short.txt").split(/\n\n/).map(&:chomp)

airports.each do |code|
  Airport.create!(code: code)
end

100.times do
  from_airport_id = to_airport_id = rand(Airport.count)+1
  to_airport_id = rand(Airport.count)+1 until to_airport_id != from_airport_id
  start_datetime = (rand(200000)-100000).minutes.since
  duration = rand(18) * 10 + 30
  Flight.create!(from_airport_id: from_airport_id,
                 to_airport_id: to_airport_id,
                 start_datetime: start_datetime,
                 duration: duration)
end
