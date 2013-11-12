Sustainabilitychecker::Application.routes.draw do
  root "static_pages#home"

  # Experience
  get "begin" => "experiment#begin"
  #   Demand pages
  get "demand" => "variables#demand"
  get "demand/:section" => "variables#demand"
  #   Supply pages
  get "supply" => "variables#supply"
  get "supply/:section" => "variables#supply"
  #   Check
  get "check" => "check#index"

  # StaticPages
  get "home" => "static_pages#home"
  get "presentation" => "static_pages#presentation"
  get "contact" => "static_pages#contact"
  post "contact/send" => "static_pages#contact_send"
  get "legal" => "static_pages#legal"
end
