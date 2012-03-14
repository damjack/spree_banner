Spree::Core::Engine.routes.prepend do
  namespace :admin do
    resources :banners
  end
end
