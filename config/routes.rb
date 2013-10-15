Sustainabilitychecker::Application.routes.draw do
  root "static_pages#home"

  # StaticPages
  get "home" => "static_pages#home"
  get "presentation" => "static_pages#presentation"
end
