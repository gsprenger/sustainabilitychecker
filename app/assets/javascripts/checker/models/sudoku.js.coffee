class window.Sudoku
  constructor:(@demographics, @diet, @households, @services, @density, @land, @bm, @agriculture, @energy) ->

  # SUDOKU DATA #
  get_TFOOD: ->
    (@diet.get_HH_food() +
      @diet.get_SG_food() +
      @diet.get_BM_food() +
      @diet.get_AG_food())

  get_TET: ->
    (@households.get_ET_HH() +
      @services.get_ET_SG() +
      @bm.get_ET_BM() +
      @agriculture.get_ET_AG() +
      @energy.get_ET_EM())

  get_THA: ->
    (@demographics.get_HA_HH() +
      @services.get_HA_SG() +
      @bm.get_HA_BM() +
      @agriculture.get_HA_AG() +
      @energy.get_HA_EM())

  get_TLU: ->
    (@agriculture.get_LU_AG() + 
      @get_LU_EM())

  get_LU_EM: ->
    if (@agriculture.get_LU_AG() > @land.get_s_lan())
      return 0
    else
      return (@land.get_s_lan() - @agriculture.get_LU_AG())

  get_DS_food: ->
    ((@get_TFOOD() / @agriculture.get_LU_AG()) * @land.get_s_lan())

  get_DS_energy: ->
    (@get_TET() * (@land.get_s_lan() - @agriculture.get_LU_AG()))

  get_imports_food: ->
    (@get_TFOOD() - @get_DS_food())

  get_imports_energy: ->
    (@get_TET() - @get_DS_energy())

  get_vimports_HA: ->
    (@get_THA() - 8760)

  get_vimports_LU: ->
    (@get_TLU() - @land.get_s_lan())
