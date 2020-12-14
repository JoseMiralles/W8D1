# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Sub.destroy_all
Post.destroy_all

(1..20).each do |i|
    User.create!({
        username: "Despacito Man ##{i}",
        password: "my_pass#{i}"
    })
end

Sub.create!({
    title: "dogs",
    description: "awfewaf",
    moderator_id: User.first.id
})

(0..10).each do |i|
    Post.create!({
        title: "Title ##{i}",
        url: "afewaf",
        author_id: User.first.id,
        sub_id: Sub.first.id
    })
end