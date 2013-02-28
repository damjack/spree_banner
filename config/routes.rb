Spree::Core::Engine.routes.prepend do
  namespace :admin do
    resources :banners do
      collection do
        post :update_positions
      end
    end
    resource :banner_settings
  end
end
