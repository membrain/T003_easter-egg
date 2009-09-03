ActionController::Routing::Routes.draw do |map|
  map.resource  :definition
  
  map.root      :controller => :definitions, :action => :index
end
