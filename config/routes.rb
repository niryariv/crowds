ActionController::Routing::Routes.draw do |map|
  # map.resources :feeds
  # 
  # map.resources :items
  # 
  map.resources :crowds
  # 
  map.resources :password_resets

  # The priority is based upon order of creation: first created -> highest priority.
  
  map.resources :crowd, :has_many => [:feeds, :items], :belongs_to => :user
  map.resources :user, :has_many => :crowds
  map.resources :feed, :belongs_to => :crowd
  map.resources :item, :belongs_to => :crowd
  
  
  map.import '/crowd/:crowd_id/import', :controller => "feeds", :action => "create" #/:url, :url => /.*/
  
  # Sample of regular route:
  # map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  # map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # You can have the root of your site routed by hooking up '' 
  # -- just remember to delete public/index.html.
  map.connect '', :controller => "crowds"

  # Allow downloading Web Service WSDL as a file with an extension
  # instead of a file named 'wsdl'
  map.connect ':controller/service.wsdl', :action => 'wsdl'
  
  # AuthLogic
  map.resource :user_session
  map.root :controller => "user_sessions", :action => "new"

  map.resource :account, :controller => "users"
  map.resources :users

  

  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end