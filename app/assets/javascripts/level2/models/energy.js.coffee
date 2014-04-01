class window.Energy
  # Data from team datasheet in CoffeeScript Object format
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

  ###
  GETTERS
  ###
  @get_s_ene_con: ->
    (Households.get_ET_HH() +
    Services.get_ET_SG() +
    Bm.get_ET_BM() +
    Agriculture.get_ET_AG())

  @get_s_ene_typ: ->
    (if Agriculture.value == 'low' then 'low' else 'high')

  @get_NSECs_ELEC: ->
    ((Households.get_ET_ELEC() * Energy.get_s_ene_con()) / 
      Energy.data.GER_EC_ELEC)
    
  @get_NSECs_FUELS: ->
    ((Households.get_ET_FUELS() * Energy.get_s_ene_con()) /
      Energy.data.GER_EC_FUELS)

  @get_GSECs_ELEC: ->
    (Energy.get_NSECs_ELEC() /
    (1 - (Energy.data.LOSSES_ELEC / 100)))
    
  @get_GSECs_FUELS: ->
    (Energy.get_NSECs_FUELS() /
    (1 - (Energy.data.LOSSES_FUELS / 100)))

  @get_LU_ELEC: ->
    Energy.loopAllWithValue(Energy.data.LU_ELEC)

  @get_LU_FUELS: ->
    Energy.loopAllWithValue(Energy.data.LU_FUELS)

  @get_ET_ELEC_EM: ->
    Energy.loopAllWithValue(Energy.data.ET_ELEC)

  @get_ET_FUELS_EM: ->
    Energy.loopAllWithValue(Energy.data.ET_FUELS)

  @get_HA_ELEC: ->
    Energy.loopAllWithValue(Energy.data.HA_ELEC)

  @get_HA_FUELS: ->
    Energy.loopAllWithValue(Energy.data.HA_FUELS)

  @get_NSEC_ELEC: -> 
    (Energy.get_NSECs_ELEC() *
    (1 + Energy.get_ET_ELEC_EM()))

  @get_NSEC_FUELS: ->
    (Energy.get_NSECs_FUELS() *
    (1 + Energy.get_ET_FUELS_EM()))

  @get_GSEC_ELEC: -> 
    (Energy.get_NSEC_ELEC() *
    (1 + (Energy.data.LOSSES_ELEC / 100)))

  @get_GSEC_FUELS: ->
    (Energy.get_NSEC_FUELS() *
    (1 + (Energy.data.LOSSES_FUELS / 100)))

  @get_LU_EM: ->
    ((Energy.get_GSEC_ELEC() * Energy.get_LU_ELEC()) +
     (Energy.get_GSEC_FUELS() * Energy.get_LU_FUELS()))

  @get_ET_EM: ->
    ((Energy.get_ET_ELEC_EM() * Energy.data.GER_EC_ELEC) +
     (Energy.get_ET_FUELS_EM() * Energy.data.GER_EC_FUELS))

  @get_HA_EM: ->
    ((Energy.get_GSEC_ELEC() * Energy.get_HA_ELEC()) +
     (Energy.get_GSEC_FUELS() * Energy.get_HA_FUELS()))

  @get_TET: ->
    ((Energy.get_GSEC_ELEC() * Energy.data.GER_EC_ELEC) +
     (Energy.get_GSEC_FUELS() * Energy.data.GER_EC_FUELS))

  ###
  FUNCTIONAL CODE
  ###
  @loopAllWithValue: (data) ->    
    typ = Energy.get_s_ene_typ()
    value = 0
    $.each data, (name, val) ->
      value = (value + 
        (Energy.value[name] * (if name == 'bio' then val[typ] else val)))
    return value

  @setup: ->
    # Get sliders
    nuc = $('[data-slider-name="s_ene_nuc"]')
    hyd = $('[data-slider-name="s_ene_hyd"]')
    win = $('[data-slider-name="s_ene_win"]')
    pho = $('[data-slider-name="s_ene_pho"]')
    csp = $('[data-slider-name="s_ene_csp"]')
    bio = $('[data-slider-name="s_ene_bio"]')
    hyg = $('[data-slider-name="s_ene_hyg"]')
    ncf = $('[data-slider-name="s_ene_ncf"]')
    # Set values
    Choice.initSliderGroup([
      Choice.createSlider(nuc, '%', [0, 25, 50, 75, 100], 25),
      Choice.createSlider(hyd, '%', [0, 25, 50, 75, 100], 25),
      Choice.createSlider(win, '%', [0, 25, 50, 75, 100], 25),
      Choice.createSlider(pho, '%', [0, 25, 50, 75, 100], 25),
      Choice.createSlider(csp, '%', [0, 25, 50, 75, 100], 0)
    ])
    Choice.initSliderGroup([
      Choice.createSlider(bio, '%', [0, 25, 50, 75, 100], 50),
      Choice.createSlider(hyg, '%', [0, 25, 50, 75, 100], 25),
      Choice.createSlider(ncf, '%', [0, 25, 50, 75, 100], 25)
    ])
    # Set trigger
    trigger = ->
      values = 
        "nuc": $(nuc).slider('value') / 100
        "hyd": $(hyd).slider('value') / 100
        "win": $(win).slider('value') / 100
        "pho": $(pho).slider('value') / 100
        "csp": $(csp).slider('value') / 100
        "bio": $(bio).slider('value') / 100
        "hyg": $(hyg).slider('value') / 100
        "ncf": $(ncf).slider('value') / 100
      Energy.trigger(values)
    # apply to all sliders
    $(nuc).on 'slidechange', trigger
    $(hyd).on 'slidechange', trigger
    $(pho).on 'slidechange', trigger
    $(win).on 'slidechange', trigger
    $(bio).on 'slidechange', trigger
    $(hyg).on 'slidechange', trigger
    $(ncf).on 'slidechange', trigger
    trigger()

  @trigger: (values) ->
    Energy.value = {}
    $.each values, (name, val) ->
      switch (name)
        when 'nuc' then Energy.value['nuc'] = val
        when 'hyd' then Energy.value['hyd'] = val
        when 'pho' then Energy.value['pv'] = val
        when 'win' then Energy.value['win'] = val
        when 'bio' then Energy.value['bio'] = val
        when 'hyg' then Energy.value['hyg'] = val
        when 'ncf' then Energy.value['ncf'] = val
        when 'csp' then Energy.value['csp'] = val
        else
          console.error('Unknown Energy values. Check cannot be performed')
          console.error(values)
