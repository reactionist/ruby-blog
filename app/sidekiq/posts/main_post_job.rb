# frozen_string_literal: true
class Posts::MainPostJob
  include Sidekiq::Job

  def perform(*args)
    main_post = Post.find_by(main: true)
    main_post&.update(main: false)

    random_post = Post.all.sample
    return false if random_post.nil?

    random_post.update(main: true)

    true
  end
end
