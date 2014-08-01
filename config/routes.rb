Sustainabilitychecker::Application.routes.draw do
  # Root
  root "site#index"

  # Website
  get "home"     => "site#index"
  get "more"     => "site#more"
  get "contact"  => "site#contact"
  get "credits"  => "site#credits"
  get "legal"    => "site#legal"
  get "glossary" => "site#glossary"

  # Checker Levels
  get "load/:expid" => "app#app"
  get "start"       => "app#app"
  get "level1"      => "app#app"
  get "level2"      => "app#app"
  get "level3"      => "app#app"
  
  # Admin pages
  get 'admin-sudoku'          => "admin#admin"
  get 'admin-sudoku/uneditables' => "admin#uneditables"

  # AJAX requests
  get "content/all"       => "content#get_all"
  get "shortener/shorten" => "shortener#shorten"
  post "glossary/new"     => "glossary#new"
  post "glossary/edit"    => "glossary#edit"
  post "glossary/remove"  => "glossary#remove"
  post "contact/send"     => "site#send_contact_email"
  put "content/save"      => "content#save"

  # URL Shortener
  get '/shrt/:id' => "shortener/shortened_urls#show"

  # Mercury
  namespace :mercury do
    resources :images
  end
  get '/editor(/*requested_uri)' => "my_mercury#edit", :as => :mercury_editor
  mount Mercury::Engine => '/'
end
