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
    # loop variables
    @THALoopExecuted = false
    @TLULoopExecuted = false

  reset: ->
    @THALoopExecuted = false
    @TLULoopExecuted = false

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

  #THA LOOP
  get_THA: ->
    if !@THALoopFinished
      @loopTHA().THA
    else
      @THALoopData.THA

  get_HA_virtual: ->
    if !@THALoopFinished
      @loopTHA().HA_virtual
    else
      @THALoopData.HA_virtual

  get_HA_HH: ->
    @demographics.get_HA_HH()

  get_HA_SG: ->
    if !@THALoopFinished
      @loopTHA().HA_SG
    else
      @THALoopData.HA_SG

  get_HA_BM: ->
    if !@THALoopFinished
      @loopTHA().HA_BM
    else
      @THALoopData.HA_BM

  get_HA_AG: ->
    if !@THALoopFinished
      @loopTHA().HA_AG
    else
      @THALoopData.HA_AG

  get_HA_EM: ->
    if !@THALoopFinished
      @loopTHA().HA_EM
    else
      @THALoopData.HA_EM

  loopTHA: ->
    THA = (@demographics.get_HA_HH() +
      @services.get_HA_SG() +
      @bm.get_HA_BM() +
      @agriculture.get_HA_AG() +
      @energy.get_HA_EM())
    HA_virtual = 0
    HA_HH = @demographics.get_HA_HH()
    HA_SG = @services.get_HA_SG()
    HA_BM = @bm.get_HA_BM()
    HA_AG = @agriculture.get_HA_AG()
    HA_EM = @energy.get_HA_EM()
    HA_PW = @demographics.get_HA_PW()
    cnt = 0
    while THA > 8761
      HA_PWs = HA_SG + HA_BM + HA_AG + HA_EM
      THAs = HA_HH + HA_PWs
      HA_SG = HA_SG * (HA_PW / HA_PWs)
      HA_BM = HA_BM * (HA_PW / HA_PWs)
      HA_AG = HA_AG * (HA_PW / HA_PWs)
      HA_EM = HA_EM * (HA_PW / HA_PWs)
      THA = HA_HH + HA_SG + HA_BM + HA_AG + HA_EM
      HA_virtual = THAs - THA
    @THALoopFinished = true
    return @THALoopData = {
      THA: THA,
      HA_virtual: HA_virtual,
      HA_HH: HA_HH,
      HA_SG: HA_SG,
      HA_BM: HA_BM,
      HA_AG: HA_AG,
      HA_EM: HA_EM
    }

  # TLU LOOP
  get_TLU: ->
    if !@TLULoopFinished
      @loopTLU().TLU
    else
      @TLULoopData.TLU

  get_LU_virtual: ->
    if !@TLULoopFinished
      @loopTLU().LU_virtual
    else
      @TLULoopData.LU_virtual

  get_LU_AG: ->
    if !@TLULoopFinished
      @loopTLU().LU_AG
    else
      @TLULoopData.LU_AG

  get_LU_EM: ->
    if !@TLULoopFinished
      @loopTLU().LU_EM
    else
      @TLULoopData.LU_EM

  loopTLU: ->
    TLU = (@agriculture.get_LU_AG() + 
      @energy.get_LU_EM())
    LU_virtual = 0
    LU_AG = @agriculture.get_LU_AG()
    LU_EM = @energy.get_LU_EM()
    cnt = 0
    while TLU > @land.get_s_lan() && cnt < 20
      cnt++
      TLUs = LU_AG + LU_EM
      LU_AG = LU_AG * (TLU / TLUs)
      LU_EM = LU_EM * (TLU / TLUs)
      TLU = LU_AG + LU_EM
      LU_virtual = TLUs - TLU
    @TLULoopFinished = true
    return @TLULoopData = {
      TLU: TLU,
      LU_virtual: LU_virtual,
      LU_AG: LU_AG,
      LU_EM: LU_EM
    }

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
    @get_HA_virtual()

  get_vimports_LU: ->
    @get_LU_virtual()

  get_EMR_WS: ->
    (@get_TET() / @get_THA())*1000

  get_EMR_HH: ->
    (@households.get_ET_HH() / @get_HA_HH())*1000

  get_EMR_SG: ->
    (@services.get_ET_SG() / @get_HA_SG())*1000

  get_EMR_BM: ->
    (@bm.get_ET_BM() / @get_HA_BM())*1000

  get_EMR_AG: ->
    (@agriculture.get_ET_AG() / @get_HA_AG())*1000

  get_EMR_EM: ->
    (@energy.get_ET_EM() / @get_HA_EM())*1000

  get_EMR_DS: ->
    (@get_DS_energy() / 8760)*1000

  get_FMD_WS: ->
    (@get_TFOOD() / @get_TLU())

  get_FMD_DS: ->
    (@get_DS_food() / @land.get_s_lan())

  get_percent_local_food: ->
    Math.round(@get_DS_food() / (@get_DS_food() + @get_imports_food()) * 100)

  get_percent_local_energy: ->
    Math.round(@get_DS_energy() / (@get_DS_energy() + @get_imports_energy()) * 100)

  getSuccess: ->
    @getFoodSuccess() && @getEnergySuccess && @getHASuccess() && @getLUSuccess() && @getEMRSuccess()

  getFoodSuccess: ->
    threshold = 80
    @get_percent_local_food() >= threshold 

  getEnergySuccess: ->
    threshold = 80
    @get_percent_local_energy() >= threshold
    
  getHASuccess: ->
    @get_THA() <= 8760 
    
  getLUSuccess: ->
    @get_TLU() <= @get_DS_LU()
    
  getEMRSuccess: ->
    @get_EMR_WS() >= 5
    
