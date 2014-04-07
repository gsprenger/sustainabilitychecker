Sustainabilitychecker::Application.routes.draw do
  # Root
  root "static_pages#home"

  # Mercury
  namespace :mercury do
    resources :images
  end
  get '/editor(/*requested_uri)' => "my_mercury#edit", :as => :mercury_editor
  mount Mercury::Engine => '/'
  # Admin panel for mercury
  get '/admin' => "admin#admin"

  # AJAX paths and other db comms
  put "content/save" => "content#save"
  get "content/all" => "content#get_all"

  # Checker Levels
  get "level1" => "level1#app"
  get "level2" => "level2#app"
  get "level3" => "level3#app"

  # Static website
  get "home" => "static_pages#home"
  get "legal" => "static_pages#legal"
end
