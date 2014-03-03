Sustainabilitychecker::Application.routes.draw do
    namespace :mercury do
      resources :images
    end
  mount Mercury::Engine => '/'
  root "static_pages#home"

  # Content
  put "content/save" => "content#save"

  # Experiments
  get "begin" => "checker#app"
  #1: Checker
    get "checker" => "checker#app"
    get "checker/get_experiment" => "checker#get_experiment"
    post "checker/save_experiment" => "checker#save_experiment"
  #2: Sudoku
  #3: Rekcehc

  # StaticPages
  get "home" => "static_pages#home"
  get "presentation" => "static_pages#presentation"
  get "contact" => "static_pages#contact"
  post "contact/send" => "static_pages#contact_send"
  get "legal" => "static_pages#legal"
end
