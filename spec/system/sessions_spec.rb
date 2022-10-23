# frozen_string_literal: true

require 'rails_helper'

describe 'ログイン画面のテスト' do
  describe 'ログイン画面(_path)のテスト' do
    before do
      visit new_user_session_path
    end
    context '表示の確認' do
      it 'ログイン画面(new_user_session_path)に「ログイン画面」が表示されているか' do
        expect(page).to have_content 'ログイン画面'
      end
      it 'new_user_registration_pathが"/users/sign_in"であるか' do
        expect(current_path).to eq('/users/sign_in')
      end
      it 'メールアドレスを入力するフォームが表示されているか' do
        expect(page).to have_field 'user[email]'
      end
      it 'パスワードを入力するフォームが表示されているか' do
        expect(page).to have_field 'user[password]'
      end
      it 'ログインボタンが表示されているか' do
        expect(page).to have_button 'ログイン'
      end
      it '新規登録画面へのリンクが表示されているか' do
        expect(page).to have_link '新規登録'
      end
    end
  end
end
