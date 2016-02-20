Rails.application.routes.draw do


  #root to: 'users#index'
  root to: 'visitors#index'
  devise_for :users, :path =>'u'
  get '/superadmins/:id' => 'users#destroy'

  get 'index_instructor' => 'enrollments#index_instructor'
   get 'index_student' => 'enrollments#index_student'

  get '/enrollments', to: 'enrollments#new', as: 'student_enrollment'


  devise_scope :user do
    get '/u/sign_out' => 'devise/sessions#destroy'
  end


   resources :users
   resources :enrollments
   resources :courses
  resources :admins
  resources :superadmins
end
