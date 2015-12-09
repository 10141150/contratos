Rails.application.routes.draw do
  namespace :system do
  get 'files/load_files'
  end
  
  namespace :system do
  post 'files/load_files'
  end

  namespace :system do
  get 'files/list_files'
  end
  
  namespace :system do
  post 'files/delete_files'
  end
  
  namespace :system do
  get 'files/delete_files'
  end

  namespace :system do
  get 'files/save_comments'
  end
  
  namespace :system do
  post 'files/save_comments'
  end

  namespace :system do
  get 'reporter/index'
  end

  namespace :system do
  get 'configuration/configure'
  end

  namespace :system do
  get 'configuration/edit'
  end

  namespace :system do
  get 'configuration/save'
  end
  namespace :system do
    resources :renewals
  end
  namespace :system do
    resources :siteviews
  end
  devise_for :admin, class_name: "Admin::User"
  namespace :system do
    resources :contracts
  end
  namespace :catalogs do
    resources :locations
  end
  namespace :catalogs do
    resources :devices
  end
  namespace :catalogs do
    resources :suppliers
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'admin/sign#index'

  # Example of regular route:
  get 'admin/sign_out' => 'admin/sign#index'
  get 'admin/mailer' => 'admin/mailerx#sendx'
  get 'catalogs/supplier/delete' => 'catalogs/suppliers#delete'
  get 'catalogs/location/delete' => 'catalogs/locations#delete'
  get 'catalogs/device/delete' => 'catalogs/devices#delete'
  get 'system/contract/delete' => 'system/contracts#delete'
  get 'system/siteview/delete' => 'system/siteviews#delete'
  get 'system/renewal/delete' => 'system/renewals#delete'
  post 'system/configuration/save' => 'system/configuration#save'
  get 'system/reporter/update_renewals' => 'system/reporter#update_renewals'
  get 'system/reporter/clean_device_contract' => 'system/reporter#clean_device_contract'
  get 'system/reporter/clean_device_supplier' => 'system/reporter#clean_device_supplier'
  get 'system/reporter/clean_supplier_contract' => 'system/reporter#clean_supplier_contract'
  get 'system/reporter/use_filter_date' => 'system/reporter#use_filter_date'


 
  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
