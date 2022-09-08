# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Seeding..."

  condiments = Answer.create([{title: 'Ketchup'}, {title: 'Mostaza'}, {title: 'Mayonesa'}])
  food = Answer.create([{title: 'Ensalada'}, {title: 'Arroz'}, {title: 'Pasta'}])
  activities = Answer.create([{title: 'Caminar'}, {title: 'Correr'}, {title: 'Dormir'}])
  moments = Answer.create([{title: 'Mañana'}, {title: 'Tarde'}, {title: 'Noche'}])
  animals = Answer.create([{title: 'Delfin'}, {title: 'Perro'}, {title: 'Gato'}])
  stop_eating = Answer.create([{title: 'Carne'}, {title: 'Leche'}, {title: 'Huevos'}])

  food_questions = Question.create([{title: 'Cual es tu comida favorita', question_type: 0, answers: food}, {title: 'Que condimentos te gustan', question_type: 1, answers: condiments}, {title: 'Describe tu lugar favorito para comer', question_type: 2}])
  life_questions = Question.create([{title: 'Cuales son tus momentos favoritos del dia', question_type: 1, answers: moments}, {title: 'Cual es tu actividad favorita', question_type: 0, answers: activities}, {title: 'Describe un dia ideal', question_type: 2}])
  animal_questions = Question.create([{title: 'Que opinas sobre los animales', question_type: 2}, {title: 'Cual es tu animal favorito', question_type: 0, answers: animals}, {title: 'Que alimentos dejaste de consumir', question_type: 1, answers: stop_eating}])

  surveys = Survey.create([{title: 'Encuesta culinaria', description: 'Una encuesta sobre comidas y condimentos para deleitarse', questions: food_questions}, {title: 'Encuesta sobre la vida', description: 'Una encuesta para saber sobre uno', questions: life_questions}, {title: 'Encuesta de animales', description: 'Que tanto sabes y conoces a los animales de este planeta', questions: animal_questions},])

puts "Seeding done."
