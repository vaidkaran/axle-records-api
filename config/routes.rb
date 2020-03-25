Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

   mount_devise_token_auth_for 'User', at: 'auth', controllers: {
     omniauth_callbacks: "overrides/omniauth_callbacks"
   }

   resources :vehicle_categories, except: [:destroy]
   resources :vehicle_brands, except: [:destroy] do
     resources :vehicle_models, except: [:destroy], shallow: true do
       resources :vehicle_variants, except: [:destroy], shallow: true
     end
   end
   resources :fuel_categories, except: [:destroy]
   resources :transmission_categories, except: [:destroy]
   resources :vendor_roles, except: [:destroy]
   resources :shops
   scope :shops do
     get ':id/add_vendor', to: 'shops#add_vendor'
     get ':id/vendors', to: 'shops#vendors'
     patch ':id/update_vendor_role', to: 'shops#update_vendor_role'
     delete ':id/remove_vendor', to: 'shops#remove_vendor'
   end

   get :add_site_role, to: 'user_site_roles#add_role'
   get :delete_site_role, to: 'user_site_roles#delete_role'
end
