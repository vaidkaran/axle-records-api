Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # user
  post 'users/create_or_sign_in', to: 'users#create_or_sign_in'

  # all vehicle_models
  get 'all_vehicle_models', to: 'vehicle_models#all_vehicle_models'

  resources :vehicle_categories, except: [:destroy]
  resources :vehicle_brands, except: [:destroy] do
    resources :vehicle_models, except: [:destroy], shallow: true do
      resources :vehicle_variants, except: [:destroy], shallow: true
    end
  end
  resources :job_profiles
  resources :spare_part_profiles
  resources :jobs, except: [:destroy]
  resources :spare_parts, except: [:destroy]
  resources :fuel_categories, except: [:destroy]
  resources :transmission_categories, except: [:destroy]
  resources :vendor_roles, except: [:destroy]
  resources :vehicles

  # bills
  get 'jobsheets/:jobsheet_id/bills', to: 'bills#index'
  get 'jobsheets/:jobsheet_id/bills/generate', to: 'bills#generate'
  delete 'jobsheets/:jobsheet_id/bills', to: 'bills#destroy'

  # shops
  resources :shops do
    resources :jobsheets, only: [:index, :show, :create]
    get 'jobsheets/:id/set_state', to: 'jobsheets#set_state'
    get 'jobsheets/:id/add_job', to: 'jobsheets#add_job'
  end
  scope :shops do
    get ':id/add_vendor', to: 'shops#add_vendor'
    get ':id/vendors', to: 'shops#vendors'
    patch ':id/update_vendor_role', to: 'shops#update_vendor_role'
    delete ':id/remove_vendor', to: 'shops#remove_vendor'
  end

  get :add_site_role, to: 'user_site_roles#add_role'
  get :delete_site_role, to: 'user_site_roles#delete_role'
  get :show_user_roles, to: 'user_site_roles#show_roles'


  # TODO: might need to setup something like this for lower envs
  # if Rails.env.development? || Rails.env.test?
  #   get :google_sign_in, to: 'auth#google_sign_in'
  # end
end
