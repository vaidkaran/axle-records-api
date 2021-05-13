# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require('securerandom')
require_relative('./seed_helper')
include SeedHelper

# site_roles
admin_role = SiteRole.create!(name: 'admin')
customer_role = SiteRole.create!(name: 'customer')
vendor_role = SiteRole.create!(name: 'vendor')
#----------------------------------------------------------------------------------------


# admin users
admin1 = User.create!(
  provider: 'https://securetoken.google.com/axle-records-firebase',
  uid: SecureRandom.hex,
  name: 'Admin User',
  email: 'admin1@ar.com',
  picture: 'https://lh6.googleusercontent.com/-iYm0d6moMeM/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucmRJ4rPrA_8HbgkgcFrM81Ltetdpg/s96-c/photo.jpg'
)
admin2 = User.create!(
  provider: 'https://securetoken.google.com/axle-records-firebase',
  uid: SecureRandom.hex,
  name: 'Admin User',
  email: 'admin2@ar.com',
  picture: 'https://lh6.googleusercontent.com/-iYm0d6moMeM/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucmRJ4rPrA_8HbgkgcFrM81Ltetdpg/s96-c/photo.jpg'
)
admin1.site_roles << admin_role
admin2.site_roles << admin_role
#----------------------------------------------------------------------------------------

# customer users
customer1 = User.create!(
  provider: 'https://securetoken.google.com/axle-records-firebase',
  uid: SecureRandom.hex,
  name: 'Customer User',
  email: 'customer1@ar.com',
  picture: 'https://lh6.googleusercontent.com/-iYm0d6moMeM/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucmRJ4rPrA_8HbgkgcFrM81Ltetdpg/s96-c/photo.jpg'
)
customer2 = User.create!(
  provider: 'https://securetoken.google.com/axle-records-firebase',
  uid: SecureRandom.hex,
  name: 'Customer User',
  email: 'customer2@ar.com',
  picture: 'https://lh6.googleusercontent.com/-iYm0d6moMeM/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucmRJ4rPrA_8HbgkgcFrM81Ltetdpg/s96-c/photo.jpg'
)
customer1.site_roles << customer_role
customer2.site_roles << customer_role
#----------------------------------------------------------------------------------------

# vendor users
vendor1 = User.create!(
  provider: 'https://securetoken.google.com/axle-records-firebase',
  uid: SecureRandom.hex,
  name: 'Vendor User',
  email: 'vendor1@ar.com',
  picture: 'https://lh6.googleusercontent.com/-iYm0d6moMeM/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucmRJ4rPrA_8HbgkgcFrM81Ltetdpg/s96-c/photo.jpg'
)
vendor2 = User.create!(
  provider: 'https://securetoken.google.com/axle-records-firebase',
  uid: SecureRandom.hex,
  name: 'Vendor User',
  email: 'vendor2@ar.com',
  picture: 'https://lh6.googleusercontent.com/-iYm0d6moMeM/AAAAAAAAAAI/AAAAAAAAAAA/AMZuucmRJ4rPrA_8HbgkgcFrM81Ltetdpg/s96-c/photo.jpg'
)
vendor1.site_roles << vendor_role
vendor2.site_roles << vendor_role
#----------------------------------------------------------------------------------------

# vehicle categories
car_category = VehicleCategory.create!(name: 'car')
bike_category = VehicleCategory.create!(name: 'bike')
scooter_category = VehicleCategory.create!(name: 'scooter')

#----------------------------------------------------------------------------------------

# Vehicle brands, models, variants
def create_vehicle_data(vehicle_data, vehicle_category)
  vehicle_data.each do |vehicle|
    brand_name = vehicle[:brand]
    # create vehicle_brand
    vehicle_brand = VehicleBrand.create!(name: brand_name)

    vehicle[:models].each do |model|
      model_name = model[:model]
      # create vehicle_model
      vehicle_model = vehicle_brand.vehicle_models.create!(name: model_name, vehicle_category_id: vehicle_category.id)

      model[:variants].each do |variant_name|
        # create vehicle_variant
        vehicle_model.vehicle_variants.create!(name: variant_name)
      end

    end

  end
end

create_vehicle_data(cars, car_category)
create_vehicle_data(bikes, bike_category)
create_vehicle_data(scooters, scooter_category)


# vehicles
vehicle_model_length = VehicleModel.all.length
vehicle_model1 = VehicleModel.all[rand(vehicle_model_length)]
customer1.vehicles.create!({
  name: vehicle_model1.name,
  vehicle_brand_id: vehicle_model1.vehicle_brand.id,
  vehicle_model_id: vehicle_model1.id,
  vehicle_variant_id: vehicle_model1.vehicle_variants.first.id,
})
vehicle_model2 = VehicleModel.all[rand(vehicle_model_length)]
customer1.vehicles.create!({
  name: vehicle_model2.name,
  vehicle_brand_id: vehicle_model2.vehicle_brand.id,
  vehicle_model_id: vehicle_model2.id,
  vehicle_variant_id: vehicle_model2.vehicle_variants.first.id,
})
vehicle_model3 = VehicleModel.all[rand(vehicle_model_length)]
customer2.vehicles.create!({
  name: vehicle_model3.name,
  vehicle_brand_id: vehicle_model3.vehicle_brand.id,
  vehicle_model_id: vehicle_model3.id,
  vehicle_variant_id: vehicle_model3.vehicle_variants.first.id,
})
vehicle_model4 = VehicleModel.all[rand(vehicle_model_length)]
customer2.vehicles.create!({
  name: vehicle_model4.name,
  vehicle_brand_id: vehicle_model4.vehicle_brand.id,
  vehicle_model_id: vehicle_model4.id,
  vehicle_variant_id: vehicle_model4.vehicle_variants.first.id,
})

