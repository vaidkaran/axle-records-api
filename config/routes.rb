Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

   mount_devise_token_auth_for 'User', at: 'auth', controllers: {
     omniauth_callbacks: "overrides/omniauth_callbacks"
   }

   resources :vehicle_categories, except: [:destroy]
   resources :vehicle_brands, except: [:destroy]
   resources :fuel_categories, :transmission_categories, :vehicle_models, :vehicle_variants
end
