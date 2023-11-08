Rails.application.routes.draw do
  root 'user_logins#new' 
  
  resources :user_logins, only: [:new, :create, :destroy] 
  get 'doctors/dashboard', to: 'doctors#dashboard', as: :doctors_dashboard 
  get 'patients/dashboard', to: 'patients#dashboard', as: :patients_dashboard 
  get 'search_doctors', to: 'patients#search_doctors'
  resources :doctors, only: [:new, :create] do 
    get 'dashboard', on: :collection
    resources :appointments, only: [] do
      get 'show_appointment', on: :member
      post 'approve_appointment', on: :member
      post 'decline_appointment', on: :member
    end
  end 
  resources :patients, only: [:new, :create] do 
    get 'dashboard', on: :collection 
    get 'search_doctors', on: :collection
  end
  resources :appointments, only: [:index, :create]
  get 'register_doctor', to: 'doctors#new', as: :register_doctor
  get 'register_patient', to: 'patients#new', as: :register_patient
end
