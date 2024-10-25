require "open-uri"

puts "cleaning DB..."
User.destroy_all # Destroy all existing users from database to avoid duplicates
Flat.destroy_all # Destroy all existing flats from database to avoid duplicates

# Creating a new user
User.create!(
            email: 'test@test.com',
            password: '123456',
            password_confirmation: '123456')
puts "User 1 created !"

puts "Creating flats..."
url = "https://raw.githubusercontent.com/lewagon/flats-boilerplate/master/flats.json"
flats = JSON.parse(URI(url).read)

# 5.times do
#   flats.each do |flat|
#     flat = Flat.new(
#       name: flat['name'],
#       price: flat['price'],
#       address: "Paris, France"
#     )
#   image = URI.open("#{flat['imageUrl']}")
#   filename = (100..9999999).random.to_s
#   flat.photo.attach(io: image, filename: filename, content_type: 'image/png')
#   flat.save!
#   end
# end


flats.each do |flat|
  begin
    flat_record = Flat.new(
      name: flat['name'],
      price: flat['price'],
      address: "Paris, France"
    )

    image_url = flat['imageUrl']
    puts "Image URL: #{image_url}" # Log the URL to check
    image = URI.open(image_url)
    filename = File.basename(image_url) # Get the filename from the URL

    flat_record.photo.attach(io: image, filename: filename, content_type: 'image/png')
    flat_record.save!
  rescue => e
    puts "Error processing flat #{flat['name']}: #{e.message}"
  end
end
