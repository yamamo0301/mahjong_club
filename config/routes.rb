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

  scope module: :public do
    resources :rules,        only: [:index, :create, :edit, :update]
    resources :players,      only: [:index, :create, :edit, :update]
    resources :score_sheets, only: [:new, :index, :show, :create, :edit, :update, :destroy]
    resources :scores,       only: [:create]
  end
end
