Rails.application.routes.draw do
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "public/homes#top"
  get "about" => "public/homes#about"
  get "admin" => "admin/homes#top"

  # TODO : admin_sign_outのURLが直接リクエストされたときにadmin_sign_in画面へ遷移させるために記述
  devise_scope :admin do
    get "admin/sign_out" => "admin/sessions#access_authorizations"
  end

  scope module: :public do
    get "users/unsubscribe" => "users#unsubscribe"
    patch "users/withdraw" => "users#withdraw"

    resources :rules,        only: [:index, :create, :edit, :update]
    resources :players,      only: [:index, :create, :edit, :update]
    resources :score_sheets, only: [:new, :index, :show, :create, :edit, :update, :destroy]
    resources :scores,       only: [:create, :update]
    resources :messages,     only: [:create]
    resources :rooms,        only: [:create, :index, :show]
    resources :users,        only: [:index, :show, :edit, :update] do
      get :search, on: :collection
      resource :relationships, only: [:create, :destroy]
      get "followings" => "relationships#followings", as: "followings"
      get "followers"  => "relationships#followers",  as: "followers"
    end
  end

  namespace :admin do
    resources :users, only: [:show, :update] do
      get :search, on: :collection
    end
    resources :rooms, only: [:show]
  end
end
