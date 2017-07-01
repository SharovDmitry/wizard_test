City.destroy_all

city_1 = City.create({name: 'Dnepr'})
city_2 = City.create({name: 'Grodno'})
city_3 = City.create({name: 'Alicante'})

hotel_1 = Hotel.create({name: 'Astoria', city_id: city_1.id})
hotel_2 = Hotel.create({name: 'Grand Hotel Ukraine', city_id: city_1.id})
hotel_3 = Hotel.create({name: 'Park Hotel', city_id: city_1.id})
hotel_4 = Hotel.create({name: 'Axelhof', city_id: city_1.id})
hotel_5 = Hotel.create({name: 'Dnepropetrovsk Hotel', city_id: city_1.id})

hotel_6 = Hotel.create({name: 'Slavia Hotel', city_id: city_2.id})
hotel_7 = Hotel.create({name: 'Turist', city_id: city_2.id})
hotel_8 = Hotel.create({name: 'Semashko Hotel', city_id: city_2.id})
hotel_9 = Hotel.create({name: 'Neman Hotel', city_id: city_2.id})
hotel_10 = Hotel.create({name: 'Hotel Prival', city_id: city_2.id})

hotel_11 = Hotel.create({name: 'Hospes Amerigo', city_id: city_3.id})
hotel_12 = Hotel.create({name: 'Hotel Sercotel', city_id: city_3.id})
hotel_13 = Hotel.create({name: 'Melia Alicante', city_id: city_3.id})
hotel_14 = Hotel.create({name: 'AC Hotel', city_id: city_3.id})
hotel_15 = Hotel.create({name: 'Tryp Gran Sol Hotel', city_id: city_3.id})

all_hotels = [hotel_1, hotel_2, hotel_3, hotel_4, hotel_5, hotel_6, hotel_7, hotel_8, hotel_9, hotel_10, hotel_11, hotel_12, hotel_13, hotel_14, hotel_15]
all_dates = (Date.parse('01.07.2017')..Date.parse('31.07.2017')).to_a

all_hotels.each do |h|
  all_dates.sample(15).each do |d|
    CheckInDate.create({date: d.to_s, hotel_id: h.id})
  end
end