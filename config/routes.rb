Rails.application.routes.draw do
  devise_for :admins, skip: [:passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  devise_for :customers, controllers: {
    passwords: "public/passwords",
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
root to: 'public/homes#top'

  namespace :admin do
    root to: 'homes#top'
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
