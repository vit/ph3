Ph3::Application.routes.draw do
  get "rpc/call"

  get "home/index"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

#  root :to => 'home#index'
#  match '/r' => -> env { [200, {"Content-Type" => "text/plain"}, [env.inspect]] }

#  match "/:action" => 'home#index', :constraints => {:host => /^ipacs.*/} 

  match "/rpc" => 'rpc#call'

  match "/ddir/" => 'dir#index', :constraints => {:host => /^(ipacs.*|www2.*|www.*|physcon.ru)/} 
#  match "/ddir/:name.html" => 'dir#any', :constraints => {:host => /^(ipacs.*|www2.*|www.*|physcon.ru)/} 
  match "/ddir/c(:category)t(:topic).html" => 'dir#any', :constraints => {:host => /^(ipacs.*|www2.*|www.*|physcon.ru)/, :topic => /\d+/, :category => /\d+/}

  match "/ipacs/" => 'old_ipacs#index', :constraints => {:host => /^(ipacs.*|www2.*|www.*|physcon.ru)/} 
#  match "/ipacs/:action.html" => 'old_ipacs', :constraints => {:host => /^(ipacs.*|www2.*|www.*|physcon.ru)/} 
#  match "/ipacs/:action.html" => 'old_ipacs#:action', :constraints => {:host => /^(ipacs.*|www2.*|www.*|physcon.ru)/} 
#  match "/ipacs/:action.html" => 'old_ipacs#any', :constraints => {:host => /^(ipacs.*|www2.*|www.*|physcon.ru)/} 
  match "/ipacs/:name.html" => 'old_ipacs#any', :constraints => {:host => /^(ipacs.*|www2.*|www.*|physcon.ru)/} 

  #root :to => 'ipacs#index', :constraints => {:host => /^(ipacs.*|www2.*|www.*|physcon.ru)/}
  #match "/:action" => 'ipacs', :constraints => {:host => /^(ipacs.*|www2.*|www.*|physcon.ru)/} 
  root :to => 'ipacs#index', :constraints => {:host => /^(ipacs.*|www2.*|www.*|physcon.ru|s4.physcon.ru)/}
  match "/:action" => 'ipacs', :constraints => {:host => /^(ipacs.*|www2.*|www.*|physcon.ru|s4.physcon.ru)/} 

constraints :subdomain => "cap.s4" do
	match '/read' => redirect('http://lib.physcon.ru/doc?id=29e59dce4f11')
	match '/submit' => redirect('http://coms.physcon.ru/conf/12/')
	root :to => 'cap#index'
	match "/:action" => 'cap'
end
constraints :subdomain => "cap" do
	match '/read' => redirect('http://lib.physcon.ru/doc?id=29e59dce4f11')
	match '/submit' => redirect('http://coms.physcon.ru/conf/12/')
	root :to => 'cap#index'
	match "/:action" => 'cap'
end
#  root :to => 'cap#index', :constraints => {:host => /^cap.*/}
#  match "/:action" => 'cap', :constraints => {:host => /^cap.*/} 

  root :to => 'lib#index', :constraints => {:host => /^(lib.*|lib2.*|lib.s4.*)/}
  match "/:action" => 'lib', :constraints => {:host => /^(lib.*|lib2.*|lib.s4.*)/} 

  root :to => 'admin#index', :constraints => {:host => /^(admin.*)/}
#  match "/:action" => 'admin', :constraints => {:host => /^(admin.*)/} 
#  match "/lib/:action" => 'admin_lib', :constraints => {:host => /^(admin.*)/} 
#  match "/news/:action" => 'admin_news', :constraints => {:host => /^(admin.*)/} 

constraints :subdomain => "admin2" do
  #scope :module => "admin", :as => "admin" do
  scope :module => "admin", as: 'admin' do
    match '/lib/' => 'lib#index'
#    match '/news/' => 'news#index'
#    resources :news
    resources :news, :as => :news_items
  end
end

constraints :subdomain => "admin" do
  #scope :module => "admin", :as => "admin" do
  scope :module => "admin", as: 'admin' do
    match '/lib/' => 'lib#index'
#    match '/news/' => 'news#index'
#    resources :news
    resources :news, :as => :news_items
  end
end


#	match  :constraints => {:host => /^ipacs.*/} do
#		match "/t" => 'home#index'
#	end

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
