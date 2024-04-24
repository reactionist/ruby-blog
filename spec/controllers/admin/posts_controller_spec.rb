# frozen_string_literal: true

require 'rails_helper'

describe Admin::PostsController do
  describe 'GET #index' do
    let(:action) { :index }
    let(:params) { {} }

    context 'when admin is signed in' do
      before do
        admin_user = create(:user, role: :admin)
        sign_in(admin_user)
      end

      it_behaves_like 'has http success'
    end

    context 'when admin is not signed in' do
      it_behaves_like 'redirects to root_path'
    end
  end

  describe 'GET #new' do
    let(:action) { :new }
    let(:params) { {} }

    context 'when admin is signed in' do
      before do
        admin_user = create(:user, role: :admin)
        sign_in(admin_user)
      end

      it_behaves_like 'has http success'
    end

    context 'when admin is not signed in' do
      it_behaves_like 'redirects to root_path'
    end
  end

  describe 'GET #edit' do
    let(:test_post) { create(:post) }
    let(:action) { :edit }
    let(:params) { { id: test_post.id } }

    context 'when admin is signed in' do
      before do
        admin_user = create(:user, role: :admin)
        sign_in(admin_user)
      end

      it_behaves_like 'has http success'
    end

    context 'when admin is not signed in' do
      it_behaves_like 'redirects to root_path'
    end
  end

  describe 'PUT #update' do
    let(:test_post) { create(:post) }
    let(:action) { :update }
    let(:new_title) { 'Updated Title' }
    let(:params) { { id: test_post.id, post: { title: new_title } } }

    context 'when admin is signed in' do
      before do
        admin_user = create(:user, role: :admin)
        sign_in(admin_user)
      end

      context 'with valid attributes' do
        it 'updates the post' do
          get(action, params:)
          test_post.reload
          expect(test_post.title).to eq(new_title)
        end
      end

      context 'with invalid attributes' do
        it 'does not update the post' do
          expect(test_post.title).not_to be_nil
        end
      end
    end

    context 'when admin is not signed in' do
      it_behaves_like 'redirects to root_path'
    end
  end

  describe 'DELETE #destroy' do
    let(:test_post) { create(:post) }
    let(:action) { :destroy }
    let(:params) { { id: test_post.id } }

    context 'when admin is signed in' do
      before do
        admin_user = create(:user, role: :admin)
        sign_in(admin_user)
      end

      it 'deletes the post' do
        post_to_delete = create(:post)
        expect do
          delete :destroy, params: { id: post_to_delete.id }
        end.to change(Post, :count).by(-1)
      end
    end

    context 'when admin is not signed in' do
      it_behaves_like 'redirects to root_path'
    end
  end

  describe 'POST #create' do
    let(:valid_attributes) { attributes_for(:post) }
    let(:invalid_attributes) { attributes_for(:post, title: nil) }
    let(:action) { :create }
    let(:params) { { post: valid_attributes } }

    context 'when admin is signed in' do
      before do
        admin_user = create(:user, role: :admin)
        sign_in(admin_user)
      end

      context 'with valid attributes' do
        it 'creates a new post' do
          expect do
            post :create, params: { post: valid_attributes }
          end.to change(Post, :count).by(1)
        end

        it 'redirects to the new post' do
          post :create, params: { post: valid_attributes }
          expected_path = response.location
          expect(response).to redirect_to(expected_path)
        end
      end
    end

    context 'when admin is not signed in' do
      it_behaves_like 'redirects to root_path'
    end
  end
end
