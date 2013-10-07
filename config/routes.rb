Sustainabilitychecker::Application.routes.draw do
  # ROOT
  root 'home#index'

  # HOME CONTROLLER
  get 'home' => 'home#index'
  get 'home/*i' => 'home#index'

  # DEMAND CONTROLLER
  get 'demand' => 'demand#index'
  get 'demand/*i' => 'demand#index'

  # SUPPLY CONTROLLER
  get 'supply' => 'supply#index'
  get 'supply/*i' => 'supply#index'

  # SUDOKU CONTROLLER
  get 'sudoku' => 'sudoku#index'
  get 'sudoku/*i' => 'sudoku#index'

  # UNSUSTAINABLE CONTROLLER
  get 'unsustainable' => 'unsustainable#index'
  get 'unsustainable/*i' => 'unsustainable#index'

  # NEXT CONTROLLER
  get 'next' => 'next#index'
  get 'next/*i' => 'next#index'

end
