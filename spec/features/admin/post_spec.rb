require 'rails_helper'

RSpec.feature 'Post management by admin', type: :feature do
  let(:admin_user) { create(:user, :admin_user) }
  let!(:posts) { create_list(:post, 3) }

  before do
    sign_in admin_user
  end

  scenario 'Admin views list of posts' do
    visit admin_posts_path

    # Перевірка наявності списку постів на сторінці
    expect(page).to have_selector('.post', count: 3)
  end

  scenario 'Admin creates a new post' do
    visit new_admin_post_path

    # Заповнення форми для створення нового поста
    fill_in 'post_title', with: 'Test Post'
    fill_in 'post_description', with: 'This is a test post.'
    attach_file 'post_photo', Rails.root.join('spec', 'fixtures', 'files', 'test_image.png')

    # Натискання на кнопку для створення поста
    click_button 'Створити'

    # Перевірка успішного створення поста
    expect(page).to have_content('Test Post')
  end

  scenario 'Admin edits a post' do
    post = posts.first
    visit edit_admin_post_path(post)

    # Зміна даних у формі редагування
    fill_in 'post_title', with: 'Updated Post Title'
    fill_in 'post_description', with: 'Updated description of the post.'

    # Натискання кнопки для збереження змін
    click_button 'Створити'

    # Перевірка успішного редагування поста
    expect(page).to have_content('Updated Post Title')
  end
end
