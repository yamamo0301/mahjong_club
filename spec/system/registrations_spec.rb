# frozen_string_literal: true

require 'rails_helper'

describe '新規登録画面のテスト' do
  describe '新規登録画面(new_user_registration_path)のテスト' do
    before do
      visit new_user_registration_path
    end
    context '表示の確認' do
      it '新規登録画面(new_user_registration_path)に「新規登録画面」が表示されているか' do
        expect(page).to have_content '新規登録画面'
      end
      it 'new_user_registration_pathが"/users/sign_up"であるか' do
        expect(current_path).to eq('/users/sign_up')
      end
      it '会員名の入力フォームが表示されているか' do
        expect(page).to have_field 'user[name]'
      end
      it '都道府県を選択するフォームが表示されているか' do
        expect(page).to have_field 'user[prefecture_id]'
      end
      it '市区町村を入力するフォームが表示されているか' do
        expect(page).to have_field 'user[municipality]'
      end
      it 'メールアドレスを入力するフォームが表示されているか' do
        expect(page).to have_field 'user[email]'
      end
      it 'パスワードを入力するフォームが表示されているか' do
        expect(page).to have_field 'user[password]'
      end
      it 'パスワード（確認用）を入力するフォームが表示されているか' do
        expect(page).to have_field 'user[password_confirmation]'
      end
      it '登録ボタンが表示されているか' do
        expect(page).to have_button '登録'
      end
      it 'ログイン画面へのリンクが表示されているか' do
        expect(page).to have_link 'ログイン'
      end
    end
  end
end
