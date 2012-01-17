Rails.application.routes.draw do
  
  namespace :admin do
    resources :banners
  end
  
end
