Sustainabilitychecker::Application.routes.draw do
  root "static_pages#home"

  # Experiments
  get "begin" => "experiment#begin"
  #1: Checker
    get "checker" => "checker#variables"
    get "checker/check" => "checker#check"
  #2: Sudoku
  #3: Rekcehc

  # StaticPages
  get "home" => "static_pages#home"
  get "presentation" => "static_pages#presentation"
  get "contact" => "static_pages#contact"
  post "contact/send" => "static_pages#contact_send"
  get "legal" => "static_pages#legal"
end
