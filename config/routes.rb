Sustainabilitychecker::Application.routes.draw do
  # Mercury
  namespace :mercury do
    resources :images
  end
  get '/editor(/*requested_uri)' => "my_mercury#edit", :as => :mercury_editor
  mount Mercury::Engine => '/'
  get '/admin' => "admin#admin"

  # Root
  root "static_pages#home"

  # Content
  put "content/save" => "content#save"

  # Experiments
    get "level1/get_experiment" => "level1#get_experiment"
    post "level1/save_experiment" => "level1#save_experiment"
  #1: 
    get "level1" => "level1#app"
  #2: 
    get "level2" => "level2#app"
  #3: 
    get "level3" => "level3#app"

  # StaticPages
  get "home" => "static_pages#home"
  get "presentation" => "static_pages#presentation"
  get "contact" => "static_pages#contact"
  post "contact/send" => "static_pages#contact_send"
  get "legal" => "static_pages#legal"
end
