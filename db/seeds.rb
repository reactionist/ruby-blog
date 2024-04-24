# frozen_string_literal: true

User.create(email: 'admin@gmail.com', password: 'admin@gmail.com', nickname: 'admin', role: 0)

30.times do
  Tag.create(title: Faker::Hipster.word)
end

20.times do
  Post.create(title: Faker::Hipster.sentence(word_count: 1),
              description: Faker::Lorem.paragraph(sentence_count: 5, supplemental: true,
                                                  random_sentences_to_add: 4),
              photo: File.open('app/assets/images/main-post.png'),
              user_id: 1,
              main: false,
              tag_ids: Array.new(rand(5)) { rand(1...30) },
              created_at: Faker::Time.backward(days: 1000))
end
