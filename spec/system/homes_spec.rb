# frozen_string_literal: true

require 'rails_helper'

describe 'トップ画面のテスト' do
  describe 'トップ画面(root_path)のテスト' do
    before do
      visit root_path
    end
    context '表示の確認' do
      it 'トップ画面(root_path)に「ようこそ麻雀倶楽部へ！」が表示されているか' do
        expect(page).to have_content 'ようこそ麻雀倶楽部へ！'
      end
      it 'root_pathが"/"であるか' do
        expect(current_path).to eq('/')
      end
      it '新規登録ボタンが表示されているか' do
        expect(page).to have_link '新規登録'
      end
      it 'ログインボタンが表示されているか' do
        expect(page).to have_link 'ログイン'
      end
    end
  end

  before do
    visit about_path
  end
  context '表示の確認' do
    it 'about画面(about_path)に「このサイトについて」が表示されているか' do
      expect(page).to have_content 'このサイトについて'
    end
    it 'about_pathが"/about"であるか' do
      expect(current_path).to eq('/about')
    end
  end
end
