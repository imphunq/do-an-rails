# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

role1 = Role.create name: "admin", description: "nguoi quan tri cua he thong", enable: true
Role.create name: "user", description: "nhan vien", enable: true
Role.create name: "user", description: "khach hang", enable: true

User.create(email: "manager@gmail.com", password: "123456", name: "nguyen van admin", status: true,
            gender: 0, role_id: role1.id)
