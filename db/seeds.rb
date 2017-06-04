# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# reset the db
Survey.delete_all
Question.delete_all
Choice.delete_all
Response.delete_all

# create the surveys
2.times do
  params = {title: Faker::Lorem.sentence,
            description: Faker::Lorem.sentences(2).join(" ")}
  Survey.create(params)
end

# create the questions
6.times do
  params = {:body => Faker::Lorem.sentence,
            :input_type => ["radio", "checkbox"].sample,
            :is_required => [true, false].sample,
            :survey_id => Survey.pluck(:id).sample}
  Question.create(params)
end

# create the choices
12.times do
  params = {:question_id => Question.pluck(:id).sample,
            :body => Faker::Lorem.sentence}
  Choice.create(params)
end

# create the responses
12.times do
  question = Question.all.sample
  params = {:question_id => question.id,
            :choice_id => question.choices.sample.id}
  begin
    Response.create(params)
  rescue ActiveRecord::RecordNotUnique
  end
end
