Sustainabilitychecker::Application.routes.draw do
  root "static_pages#home"

  # Experiments
  get "begin" => "checker#index"
  #1: Checker
    get "checker" => "checker#index"
    get "checker/cards" => "checker#load_cards"
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
