ActionController::Routing::Routes.draw do |map|

  map.root :controller => :crowds, :action => :index

  map.resources :crowds

  # The priority is based upon order of creation: first created -> highest priority.
  
  map.resources :crowd, :has_many => [:feeds, :items], :belongs_to => :user
  map.resources :user, :has_many => :crowds
  map.resources :feed, :belongs_to => :crowd
  map.resources :item, :belongs_to => :crowd
  
  
  map.import '/crowd/:crowd_id/import', :controller => "feeds", :action => "create"
  
  # Sample of regular route:
  # map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  # map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)


  # Allow downloading Web Service WSDL as a file with an extension
  # instead of a file named 'wsdl'
  map.connect ':controller/service.wsdl', :action => 'wsdl'

  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end