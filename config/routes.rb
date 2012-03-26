Spree::Core::Engine.routes.prepend do
  namespace :admin do
    resources :banners do
      collection do
        post :update_positions
      end
    end
  end
end
