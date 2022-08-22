Rails.application.routes.draw do

  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'public/homes#top'
  get 'about' => 'public/homes#about'
  get 'admin' => 'admin/homes#top'

  scope module: :public do
    resources :rules,        only: [:index, :create, :edit, :update]
    resources :players,      only: [:index, :create, :edit, :update]
    resources :score_sheets, only: [:new, :index, :show, :create, :edit, :update, :destroy]
    resources :scores,       only: [:create]
    resources :messages,     only: [:create]
    resources :rooms,        only: [:create, :index, :show]
    resources :users,        only: [:index, :show, :edit, :search] do
      get :search, on: :collection
      resource :relationships, only: [:index, :create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers'  => 'relationships#followers',  as: 'followers'
    end
  end

  namespace :admin do
    resources :users, only: [:search] do
      get :search, on: :collection
    end
  end
end
