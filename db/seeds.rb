
Driver.delete_all
Bus.delete_all
Trip.delete_all
TripLocation.delete_all
ApiKey.create!

Driver.create!({name:"Tayseer", email:"tayeseer@hotmail.com", password:"tayseer123", auth_token: ""})
Driver.create!({name:"Dina", email:"dina@hotmail.com", password:"dina123", auth_token: ""})

Bus.create!({code:"abc123"})
Bus.create!({code:"xyz987"})
