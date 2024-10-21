Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_for :users


  resources :blog_posts

  root "blog_posts#index"
end
