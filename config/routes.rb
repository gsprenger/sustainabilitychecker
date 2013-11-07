Sustainabilitychecker::Application.routes.draw do
  root "static_pages#home"

  # Experience
  get "begin" => "experiment#begin"
  # Phase One
  get "demand" => "variables#demand"
  get "supply" => "variables#supply"

  # StaticPages
  get "home" => "static_pages#home"
  get "presentation" => "static_pages#presentation"
  get "contact" => "static_pages#contact"
  post "contact/send" => "static_pages#contact_send"
  get "legal" => "static_pages#legal"
end
