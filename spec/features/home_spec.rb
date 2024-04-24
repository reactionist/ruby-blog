require 'rails_helper'

RSpec.feature 'Viewing pages', type: :feature do
  let!(:main_post) { create(:post, title: 'Main Post', description: 'Main post description') }
  let!(:posts) { create_list(:post, 5) }

  scenario 'Visitor views the home page' do
    visit root_path

    # Перевірка наявності головного поста на головній сторінці
    expect(page).to have_content('Main Post')
    expect(page).to have_content('Main post description')

    # Перевірка наявності інших постів на головній сторінці
    expect(page).to have_selector('.post-column', count: 6)

    # Перевірка наявності пагінації на головній сторінці
    expect(page).to have_selector('.pagination__inner')
  end

  scenario 'Visitor views a post' do
    visit post_path(main_post)

    # Перевірка відображення основної інформації про пост
    expect(page).to have_content('Main Post')
    expect(page).to have_content('Main post description')

    # Перевірка наявності зображення поста (якщо воно є)
    expect(page).to have_selector('.post-main-img')

    # Перевірка наявності тегів поста
    expect(page).to have_selector('.intro-block__tag', count: main_post.tags.count)

    # Перевірка відображення схожих постів
    expect(page).to have_content('Схожі публікації')
    expect(page).to have_selector('.post-column', count: 0)
  end
end
