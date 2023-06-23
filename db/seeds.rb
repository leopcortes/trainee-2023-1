# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create(id:1, name: "Joao", email: "joao@gmail.com", password: "12345678", is_admin: true)
User.create(id:2, name: "Maria", email: "maria@gmail.com", password: "12345678", is_admin: true)
User.create(id:3, name: "Pedro", email: "pedro@gmail.com", password: "12345678", is_admin: true)

Post.create(id:1, title: "Tutorial como subir de elo no lol", content: "Desista", user_id: 1)
Post.create(id:2, title: "Aonde assistir homem aranha online", content: "TV Box", user_id: 2)
Post.create(id:3, title: "O que e um pontinho azul no ceu", content: "Urublue", user_id: 3)

Category.create(id:1, name: "Jogos", description: "Valorant/LOL/COD/Fortnite/Minecraft/etc")
Category.create(id:2, name: "TV", description: "Filmes/Series/Animes/Streamings/etc")
Category.create(id:3, name: "Memes", description: "Piadas/Humor/Risos")

PostCategory.create(id:1, post_id: 1, category_id: 1)
PostCategory.create(id:2, post_id: 1, category_id: 3)
PostCategory.create(id:3, post_id: 2, category_id: 2)
PostCategory.create(id:4, post_id: 3, category_id: 3)

Feedback.create(id:1, like: false, post_id: 1, user_id: 2)
Feedback.create(id:2, like: true, post_id: 1, user_id: 3)
Feedback.create(id:3, like: false, post_id: 2, user_id: 1)
Feedback.create(id:4, like: true, post_id: 2, user_id: 3)
Feedback.create(id:5, like: false, post_id: 3, user_id: 1)
Feedback.create(id:6, like: true, post_id: 3, user_id: 2)

Commentary.create(id:1, content: ":(", post_id: 1, user_id: 2)
Commentary.create(id:2, content: "Hahaha", post_id: 1, user_id: 3)
Commentary.create(id:3, content: "Que pena", post_id: 2, user_id: 1)
Commentary.create(id:4, content: "Legal", post_id: 2, user_id: 3)
Commentary.create(id:5, content: ":/", post_id: 3, user_id: 1)
Commentary.create(id:6, content: "Kkkkkkkk", post_id: 3, user_id: 2)