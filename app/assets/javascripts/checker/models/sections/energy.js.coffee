class window.EnergyModel extends SectionModel
  constructor: ->
    @name = 'energy'
    @slug = 's_ene'
    @type = 'supply'
    @headerIcon = 'fa-bolt'
    @i18nPrefix = 'chkr_ene'
    @choices = []
    @choices.push(new SliderGroupModel([
        new SliderModel('s_ene_nuc', [0, 25,50, 75, 100], 0),
        new SliderModel('s_ene_hyd', [0, 25,50, 75, 100], 25),
        new SliderModel('s_ene_win', [0, 25,50, 75, 100], 25),
        new SliderModel('s_ene_pho', [0, 25,50, 75, 100], 25),
        new SliderModel('s_ene_csp', [0, 25,50, 75, 100], 25)
      ]))
    @choices.push(new SliderGroupModel([
        new SliderModel('s_ene_bio', [0, 25,50, 75, 100], 25),
        new SliderModel('s_ene_hyg', [0, 25,50, 75, 100], 50),
        new SliderModel('s_ene_ncf', [0, 25,50, 75, 100], 25)
      ]))
    @app = App.get()

  # SUDOKU DATA #  
  @data =
    "GER_EC_ELEC":  2.6
    "GER_EC_FUELS": 1
    "LOSSES_ELEC":  15 
    "LOSSES_FUELS": 10 
    "LU_ELEC":
      "nuc": 0 # negl.
      "hyd": 0 # negl.
      "pv":  2.4
      "csp": 5.1
      "win": 9.1
    "LU_FUELS":
      "bio": 
        "low":  23
        "high": 168
      "hyg": 3
      "ncf": 0 # negl.
    "ET_ELEC":
      "nuc": 0.03
      "hyd": 0.09
      "pv":  0.15
      "csp": 0.07
      "win": 0.05
      "bio":
        "low":  0 # negl.
        "high": 0 # negl.
      "hyg": 0.4
      "ncf": 0 # negl.
    "ET_FUELS":
      "nuc": 0.1
      "hyd": 0 # negl.
      "pv":  0 # negl.
      "csp": 0.01
      "win": 0 # negl.
      "bio":
        "low":  0.67
        "high": 0.91
      "hyg": 0 # negl.
      "ncf": 0.71
    "HA_ELEC":
      "nuc": 133
      "hyd": 133
      "pv":  139
      "csp": 161
      "win": 56
    "HA_FUELS":
      "bio":
        "low":  6667
        "high": 4472
      "hyg": 139
      "ncf": 1187

  getValue: ->

  get_s_ene_con: ->
    (@app.households.get_ET_HH() +
    @app.services.get_ET_SG() +
    @app.bm.get_ET_BM() +
    @app.agriculture.get_ET_AG())

  get_s_ene_typ: ->
    (if @app.agriculture.choices[0].value == 'low' then 'low' else 'high')

  get_NSECs_ELEC: ->
    ((@app.households.get_ET_ELEC() * @get_s_ene_con()) / 
      @data.GER_EC_ELEC)
    
  get_NSECs_FUELS: ->
    ((@app.households.get_ET_FUELS() * @get_s_ene_con()) /
      @data.GER_EC_FUELS)

  get_GSECs_ELEC: ->
    (@get_NSECs_ELEC() /
    (1 - (@data.LOSSES_ELEC / 100)))
    
  get_GSECs_FUELS: ->
    (@get_NSECs_FUELS() /
    (1 - (@data.LOSSES_FUELS / 100)))

  get_LU_ELEC: ->
    @loopAllWithValue(@data.LU_ELEC)

  get_LU_FUELS: ->
    @loopAllWithValue(@data.LU_FUELS)

  get_ET_ELEC_EM: ->
    @loopAllWithValue(@data.ET_ELEC)

  get_ET_FUELS_EM: ->
    @loopAllWithValue(@data.ET_FUELS)

  get_HA_ELEC: ->
    @loopAllWithValue(@data.HA_ELEC)

  get_HA_FUELS: ->
    @loopAllWithValue(@data.HA_FUELS)

  get_NSEC_ELEC: -> 
    (@get_NSECs_ELEC() *
    (1 + @get_ET_ELEC_EM()))

  get_NSEC_FUELS: ->
    (@get_NSECs_FUELS() *
    (1 + @get_ET_FUELS_EM()))

  get_GSEC_ELEC: -> 
    (@get_NSEC_ELEC() *
    (1 + (@data.LOSSES_ELEC / 100)))

  get_GSEC_FUELS: ->
    (@get_NSEC_FUELS() *
    (1 + (@data.LOSSES_FUELS / 100)))

  get_LU_EM: ->
    ((@get_GSEC_ELEC() * @get_LU_ELEC()) +
     (@get_GSEC_FUELS() * @get_LU_FUELS()))

  get_ET_EM: ->
    ((@get_ET_ELEC_EM() * @data.GER_EC_ELEC) +
     (@get_ET_FUELS_EM() * @data.GER_EC_FUELS))

  get_HA_EM: ->
    ((@get_GSEC_ELEC() * @get_HA_ELEC()) +
     (@get_GSEC_FUELS() * @get_HA_FUELS()))

  get_TET: ->
    ((@get_GSEC_ELEC() * @data.GER_EC_ELEC) +
     (@get_GSEC_FUELS() * @data.GER_EC_FUELS))
