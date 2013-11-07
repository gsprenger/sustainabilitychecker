Sustainabilitychecker::Application.routes.draw do
  root "static_pages#home"

  # Experience
  get "begin" => "experiment#begin"
  #   Demand pages
    get "demand" => "variables#demand"
    get "demand/demographics" => "variables#demographics"
    get "demand/diet" => "variables#diet"
    get "demand/households" => "variables#households"
  #   Supply pages
    get "supply" => "variables#supply"
    get "supply/services" => "variables#services"
    get "supply/electricity" => "variables#electricity"
    get "supply/fuels" => "variables#fuels"
    get "supply/industrialization" => "variables#industrialization"
  #   Check
    get "check" => "check#index"

  # StaticPages
  get "home" => "static_pages#home"
  get "presentation" => "static_pages#presentation"
  get "contact" => "static_pages#contact"
  post "contact/send" => "static_pages#contact_send"
  get "legal" => "static_pages#legal"
end
