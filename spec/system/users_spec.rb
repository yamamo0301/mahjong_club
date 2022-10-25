require 'rails_helper'

describe 'ログインとログアウト' do
  before do
    @user = FactoryBot.create(:user)
  end
  it "login" do
    visit new_user_session_path

  #   # # ログインフォームにEmailとパスワードを入力する
    fill_in 'user_email', with: @user.email
    fill_in 'パスワード', with: @user.password
  #   # # ログインボタンをクリックする
    click_button 'ログイン'
  #   # # ログインに成功したことを検証する
    expect(page).to have_content 'ログインしました'
  end
end