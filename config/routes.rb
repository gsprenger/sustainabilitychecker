Sustainabilitychecker::Application.routes.draw do
  root "static_pages#home"

  # StaticPages
  get "home" => "static_pages#home"
  get "presentation" => "static_pages#presentation"
  get "contact" => "static_pages#contact"
  get "legal" => "static_pages#legal"
end
