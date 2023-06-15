# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Post.create!(title: "Tutorial como subir de elo no lol", content: "Desista")
Post.create!(title: "Aonde assistir homem aranha online", content: "TV Box")
Post.create!(title: "O que e um pontinho azul no ceu", content: "Urublue")

Category.create!(name: "Jogos", description: "Valorant/LOL/COD/Fortnite/Minecraft/etc")
Category.create!(name: "TV", description: "Filmes/Series/Animes/Streamings/etc")
Category.create!(name: "Memes", description: "Piadas/Humor/Risos")

Feedback.create!(like: false, post_id: 1)