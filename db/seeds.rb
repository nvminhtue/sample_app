User.create!(name: "Nguyen Viet Minh Tue",
  email: "nvminhtue@gmail.com",
  password: "123123123",
  password_confirmation: "123123123",
  admin: true,
  activated: true,
  activated_at: Time.zone.now)

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
    email: email,
    password: password, password_confirmation: password,
    activated: true, activated_at: Time.zone.now)
end
