# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


#coins
penny = Coin.create(name: 'penny', value: 1, count: 5 )
nickel = Coin.create(name: 'nickel', value: 5, count: 5 )
dime = Coin.create(name: 'dime', value: 10, count: 5 )
nickel = Coin.create(name: 'quarter', value: 25, count: 5)

#users
admin = User.create(email: 'syedm199343@gmail.com', password: 'password', account_type: 'admin')
user =  User.create(email: 'syed199343@gmail.com', password: 'password_2')

#transactions
transaction_1 = Transaction.create(coin_id: 1, user_id: 1, transaction_type: "deposit")
transaction_2 = Transaction.create(coin_id: 2, user_id: 1, transaction_type: "withdrawal")
transaction_3 = Transaction.create(coin_id: 3, user_id: 2, transaction_type: "withdrawal")