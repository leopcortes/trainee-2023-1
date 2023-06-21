# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create(name: "Joao", email: "joao@gmail.com", password: "12345678", is_admin: true)
Post.create(title: "Tutorial como subir de elo no lol", content: "Desista")
Category.create(name: "Jogos", description: "Valorant/LOL/COD/Fortnite/Minecraft/etc")
Feedback.create(like: false, post_id: 1)
Feedback.create(like: true, post_id: 1)
Commentary.create(content: ":(", post_id: 1)
Commentary.create(content: "Hahaha", post_id: 1)

User.create(name: "Maria", email: "maria@gmail.com", password: "12345678", is_admin: true)
Post.create(title: "Aonde assistir homem aranha online", content: "TV Box")
Category.create(name: "TV", description: "Filmes/Series/Animes/Streamings/etc")
Feedback.create(like: false, post_id: 2)
Feedback.create(like: true, post_id: 2)
Commentary.create(content: "Que pena", post_id: 2)
Commentary.create(content: "Legal", post_id: 2)


User.create(name: "Pedro", email: "pedro@gmail.com", password: "12345678", is_admin: false)
Post.create(title: "O que e um pontinho azul no ceu", content: "Urublue")
Category.create(name: "Memes", description: "Piadas/Humor/Risos")
Feedback.create(like: false, post_id: 3)
Feedback.create(like: true, post_id: 3)
Commentary.create(content: ":/", post_id: 3)
Commentary.create(content: "Kkkkkkkk", post_id: 3)


PostCategory.create(post_id: 1, category_id: 1)
PostCategory.create(post_id: 1, category_id: 3)
PostCategory.create(post_id: 2, category_id: 2)
PostCategory.create(post_id: 3, category_id: 3)