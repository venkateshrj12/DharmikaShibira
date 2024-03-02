Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: redirect('/admin')

  namespace :admin do
    get 'cashbook/export_cashbook_file', to: 'cashbook#export_cashbook_file', as: :export_cashbook_file
  end

  resources :users
end
