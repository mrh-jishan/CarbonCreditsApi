# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end



# Create Users
user1 = User.find_by(email: 'user1@example.com')
user2 = User.find_by(email: 'user2@example.com')

# Create Commutes for User 1
commute1 = user1.commutes.create!(from_location: 'New York', to_location: 'Manhattan', transport_mode: 'public_transport', created_at: Time.now, updated_at: Time.now)
commute2 = user1.commutes.create!(from_location: 'Los Angeles', to_location: 'Pasadena',transport_mode: 'carpooling', created_at: Time.now, updated_at: Time.now)
commute3 = user1.commutes.create!(from_location: 'Work From Home', to_location: 'Work From Home',transport_mode: 'work_from_home', created_at: Time.now, updated_at: Time.now)
commute4 = user1.commutes.create!(from_location: 'San Francisco', to_location: 'Oakland',transport_mode: 'private_vehicle', created_at: Time.now, updated_at: Time.now)

# Create Locations for Commute 1 (Public Transport)
commute1.locations.create!(latitude: 40.7128, longitude: -74.0060, created_at: '2025-04-01 08:00:00', updated_at: '2025-04-01 08:00:00') # New York
commute1.locations.create!(latitude: 40.7306, longitude: -73.9352, created_at: '2025-04-01 08:30:00', updated_at: '2025-04-01 08:30:00') # Manhattan

# Create Locations for Commute 2 (Carpooling)
commute2.locations.create!(latitude: 34.0522, longitude: -118.2437, created_at: '2025-04-02 09:00:00', updated_at: '2025-04-02 09:00:00') # Los Angeles
commute2.locations.create!(latitude: 34.1397, longitude: -118.0353, created_at: '2025-04-02 09:45:00', updated_at: '2025-04-02 09:45:00') # Pasadena

# No locations for Commute 3 (Work From Home)

# Create Locations for Commute 4 (Private Vehicle)
commute4.locations.create!(latitude: 37.7749, longitude: -122.4194, created_at: '2025-04-03 07:30:00', updated_at: '2025-04-03 07:30:00') # San Francisco
commute4.locations.create!(latitude: 37.8044, longitude: -122.2711, created_at: '2025-04-03 08:15:00', updated_at: '2025-04-03 08:15:00') # Oakland


# Create Commutes for User 2
commute5 = user2.commutes.create!(from_location: 'London', to_location: 'Canary Wharf', transport_mode: 'public_transport', created_at: Time.now, updated_at: Time.now)
commute6 = user2.commutes.create!(from_location: 'Paris', to_location: 'Eiffel Tower', transport_mode: 'carpooling', created_at: Time.now, updated_at: Time.now)

# Create Locations for Commute 5 (Public Transport)
commute5.locations.create!(latitude: 51.5074, longitude: -0.1278, created_at: '2025-04-04 10:00:00', updated_at: '2025-04-04 10:00:00') # London
commute5.locations.create!(latitude: 51.5155, longitude: -0.0922, created_at: '2025-04-04 10:30:00', updated_at: '2025-04-04 10:30:00') # Canary Wharf

# Create Locations for Commute 6 (Carpooling)
commute6.locations.create!(latitude: 48.8566, longitude: 2.3522, created_at: '2025-04-05 08:00:00', updated_at: '2025-04-05 08:00:00') # Paris
commute6.locations.create!(latitude: 48.8584, longitude: 2.2945, created_at: '2025-04-05 08:30:00', updated_at: '2025-04-05 08:30:00') # Eiffel Tower
