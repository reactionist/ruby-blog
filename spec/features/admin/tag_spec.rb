require 'rails_helper'

RSpec.feature 'Tag management', type: :feature do
  let(:admin_user) { create(:user, :admin_user) }
  let!(:tag) { create(:tag, title: 'Test Tag') }

  before do
    sign_in admin_user
  end

  scenario 'Admin edits a tag' do
    visit admin_tags_path

    # Click on the edit link
    find(".edit a[href='#{edit_admin_tag_path(tag)}']").click

    # Fill in the form with new tag title
    fill_in 'tag_title', with: 'Edited Tag'

    # Click on the save button
    find('input[type="submit"]').click

    # Verify that the tag title is updated
    expect(page).to have_content('Edited Tag')
  end

  scenario 'Admin deletes a tag', js: true do
    visit admin_tags_path

    # Click on the delete link and confirm deletion

    find("#Modal#{tag.id}").click
    find("#deleteModal#{tag.id}").click

    # Verify that the tag is deleted
    expect(page).not_to have_content('Test Tag')
  end
end
