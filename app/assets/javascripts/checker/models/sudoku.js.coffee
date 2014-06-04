class window.Sudoku
  constructor: ->
    app = App.get()
    @demographics = app.demographics
    @diet = app.diet
    @households = app.households
    @services = app.services
    @land = app.land
    @bm = app.bm
    @agriculture = app.agriculture
    @energy = app.energy

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
      @energy.get_LU_EM())

  get_DS_food: ->
    Math.min(@get_TFOOD(), ((@get_TFOOD() / @agriculture.get_LU_AG()) * @land.get_s_lan()))

  get_DS_energy: ->
    val = 0
    if (@agriculture.get_LU_AG() > @land.get_s_lan())
      val = @energy.get_GSEC_EM_no_land()
    else if (@energy.get_LU_EM() > (@land.get_s_lan() - @agriculture.get_LU_AG()))
      val = @energy.get_GSEC_EM_no_land() + ((@land.get_s_lan() - @agriculture.get_LU_AG())/@energy.get_LU_average()) * 1000
    else
      val = @energy.get_GSEC_EM_no_land() + (@energy.get_LU_EM()/@energy.get_LU_average()) * 1000
    return Math.min(@get_TET(), val)

  get_DS_LU: ->
    Math.min(@land.get_s_lan(), (@energy.get_LU_EM() + @agriculture.get_LU_AG()))

  get_imports_food: ->
    (@get_TFOOD() - @get_DS_food())

  get_imports_energy: ->
    (@get_TET() - @get_DS_energy())

  get_vimports_HA: ->
    val = (@get_THA() - 8760)
    if (val < 0)
      return 0
    else
      return val

  get_vimports_LU: ->
    val = (@get_TLU() - @get_DS_LU())
    if (val < 0)
      return 0
    else
      return val

  get_EMR_WS: ->
    (@get_TET() / @get_THA())*1000

  get_EMR_HH: ->
    (@households.get_ET_HH() / @demographics.get_HA_HH())*1000

  get_EMR_SG: ->
    (@services.get_ET_SG() / @services.get_HA_SG())*1000

  get_EMR_BM: ->
    (@bm.get_ET_BM() / @bm.get_HA_BM())*1000

  get_EMR_AG: ->
    (@agriculture.get_ET_AG() / @agriculture.get_HA_AG())*1000

  get_EMR_EM: ->
    (@energy.get_ET_EM() / @energy.get_HA_EM())*1000

  get_EMR_DS: ->
    (@get_DS_energy() / 8760)*1000

  get_FMD_DS: ->
    (@get_DS_food() / @agriculture.get_LU_AG())

  get_percent_local_food: ->
    Math.round(@get_DS_food() / (@get_DS_food() + @get_imports_food()) * 100)

  get_percent_local_energy: ->
    Math.round(@get_DS_energy() / (@get_DS_energy() + @get_imports_energy()) * 100)

  getSuccess: ->
    threshold = 80
    (@get_percent_local_food() >= threshold && @get_percent_local_energy() >= threshold)

  getFoodSuccess: ->
    threshold = 80
    @get_percent_local_food() >= threshold 

  getEnergySuccess: ->
    threshold = 80
    @get_percent_local_energy() >= threshold
    
  getHASuccess: ->
    true
    
  getLUSuccess: ->
    true
    
  getEMRSuccess: ->
    true
    
