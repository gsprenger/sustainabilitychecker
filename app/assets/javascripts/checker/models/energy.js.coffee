class window.Energy
  # Data from team datasheet in JSON format
  # http://www.json.org/ for info about the format
  @data =
    {
    }

  # Getters used by other models
 
  # Functional code 
  @setup: ->
    # Get sliders
    nuc = $('[data-slider-name="s_ene_nuc"]')
    hyd = $('[data-slider-name="s_ene_hyd"]')
    pho = $('[data-slider-name="s_ene_pho"]')
    win = $('[data-slider-name="s_ene_win"]')
    bio = $('[data-slider-name="s_ene_bio"]')
    hyg = $('[data-slider-name="s_ene_hyg"]')
    ncf = $('[data-slider-name="s_ene_ncf"]')
    # Set values
    Choice.initSliderGroup([
      Choice.createSlider(nuc, '%', [0, 25, 50, 75, 100], 25),
      Choice.createSlider(hyd, '%', [0, 25, 50, 75, 100], 25),
      Choice.createSlider(pho, '%', [0, 25, 50, 75, 100], 25),
      Choice.createSlider(win, '%', [0, 25, 50, 75, 100], 25)
    ])

    Choice.initSliderGroup([
      Choice.createSlider(bio, '%', [0, 25, 50, 75, 100], 50),
      Choice.createSlider(hyg, '%', [0, 25, 50, 75, 100], 25),
      Choice.createSlider(ncf, '%', [0, 25, 50, 75, 100], 25)
    ])
    # Set trigger
    trigger = ->
      val = 0
      Energy.trigger(val)
    $(nuc).on 'slidechange', trigger
    $(hyd).on 'slidechange', trigger
    $(pho).on 'slidechange', trigger
    $(win).on 'slidechange', trigger
    $(bio).on 'slidechange', trigger
    $(hyg).on 'slidechange', trigger
    $(ncf).on 'slidechange', trigger
    trigger()

  @trigger: (value) ->
    Energy.value = value
