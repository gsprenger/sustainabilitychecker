class window.SliderImageView
  constructor:(@section, @slidergroupSlug) ->
    @p = @section.i18nPrefix
    @$el = $("<div id='#{@p_sliders_page}' class='sliders-image-main'>")
    if !App.get().isMercury
      $(window).on "updatesliderimage", (e, data) =>
        @updateImg(data)

  render: ->
    if !App.get().isMercury
      html = """
          <img src='' title=''>
          <div class='description'>
          </div>
        """
    else 
      html = """
          Content located in Uneditables
        """
    @$el.html(html)
    @updateImg
      section: 'd_hou',
      slider: 'd_hou_urb',
      value: App.get().sudoku.households.get_urb()
    @updateImg
      section: 'd_ser',
      slider: 'd_ser_edu',
      value: App.get().sudoku.services.get_edu()
    @updateImg
      section: 's_ene',
      slidergroup: 'ele',
      slider: 's_ene_nuc',
      value: App.get().sudoku.energy.get_nuc()
    @updateImg
      section: 's_ene',
      slidergroup: 'fue',
      slider: 's_ene_bio',
      value: App.get().sudoku.energy.get_bio()
    @events()
    return this

  events: ->

  updateImg: (data) ->
    if (data.section == @section.slug and !@slidergroupSlug) or 
      (data.slidergroup == @slidergroupSlug and @slidergroupSlug)
        sudokuModel = App.get().sudoku
        $img = @$el.find('img')
        $desc = @$el.find('.description')
        # HH
        if data.section == 'd_hou'
          # get values. Since we're doing it while sliding it is not possible to get the value
          # of the sliding slider directly. Have to get it from event data.
          urb = (if data.slider == 'd_hou_urb' then data.value else sudokuModel.households.get_urb())
          sub = (if data.slider == 'd_hou_sub' then data.value else sudokuModel.households.get_sub())
          apa = (if data.slider == 'd_hou_apa' then data.value else sudokuModel.households.get_apa())
          slu = sudokuModel.households.get_slu()
          #console.log("Household image update! urb#{urb} sub#{sub} apa#{apa}")
          contextSlug = @getHHContextSlug(urb, sub, apa, slu)
        # services
        else if data.section == 'd_ser'
          edu = (if data.slider == 'd_ser_edu' then data.value+1 else sudokuModel.services.get_edu())
          med = (if data.slider == 'd_ser_med' then data.value+1 else sudokuModel.services.get_med())
          pub = (if data.slider == 'd_ser_pub' then data.value+1 else sudokuModel.services.get_pub())
          tra = (if data.slider == 'd_ser_tra' then data.value+1 else sudokuModel.services.get_tra())
          #console.log("Services image update! edu#{edu} med#{med} pub#{pub} tra#{tra}")
          contextSlug = @getSGContextSlug(edu, med, pub, tra)
        # elec
        else if data.section == 's_ene' && data.slidergroup == 'ele'
          nuc = (if data.slider == 's_ene_nuc' then data.value else sudokuModel.energy.get_nuc())
          hyd = (if data.slider == 's_ene_hyd' then data.value else sudokuModel.energy.get_hyd())
          win = (if data.slider == 's_ene_win' then data.value else sudokuModel.energy.get_win())
          pho = (if data.slider == 's_ene_pho' then data.value else sudokuModel.energy.get_pho())
          csp = (if data.slider == 's_ene_csp' then data.value else sudokuModel.energy.get_csp())
          #console.log("Energy Elec image update! nuc#{nuc} hyd#{hyd} win#{win} pho#{pho} csp#{csp}")
          contextSlug = @getElecContextSlug(nuc, hyd, win, pho, csp)
        # fuels
        else if data.section == 's_ene' && data.slidergroup == 'fue'
          bio = (if data.slider == 's_ene_bio' then data.value else sudokuModel.energy.get_bio())
          hyg = (if data.slider == 's_ene_hyg' then data.value else sudokuModel.energy.get_hyg())
          ncf = (if data.slider == 's_ene_ncf' then data.value else sudokuModel.energy.get_ncf())
          #console.log("Energy Fuel image update! bio#{bio} hyg#{hyg} ncf#{ncf}")
          contextSlug = @getFuelsContextSlug(bio, hyg, ncf)
        # Now we got the data, update img
        c = App.get().content
        p = @section.i18nPrefix + (if @slidergroupSlug then @slidergroupSlug else '')
        prefix = "sligm_#{p}_#{contextSlug}_"
        $img.attr('src', "#{c.text(prefix+'img', 'none')}")
        $img.attr('title', "#{c.text(prefix+'imgcred', 'none')}")
        $desc.html("<div class='desc'>#{c.text(prefix+'desc', 'none')}</div><div class='descsub'><small>#{c.text(prefix+'descsub', 'none')}</small></div>")

  getHHContextSlug:(urb, sub, apa, slu) ->
    prop = if urb == 30 then 'l' else if urb == 50 then 'h' else ''
    "#{sub}-#{apa}-#{slu}#{prop}"

  getSGContextSlug:(edu, med, pub, tra) ->
    total = edu + med + pub + tra
    if total > 9
      return 'high'
    else if total > 6
      return 'med'
    else
      return 'low'

  getElecContextSlug:(nuc, hyd, win, pho, csp) ->
    if nuc == 100
      return 'nuc100'
    else if hyd == 100
      return 'hyd100'
    else if win == 100
      return 'win100'
    else if pho == 100
      return 'pho100'
    else if csp == 100
      return 'csp100'
    else if nuc >= 75
      return 'nuc75'
    else if hyd >= 75
      return 'hyd75'
    else if nuc == 0
      return 'nuc0'
    else
      return 'mixed'

  getFuelsContextSlug:(bio, hyg, ncf) ->
    if bio >= 75
      return 'bio75'
    else if hyg >= 75
      return 'hyg75'
    else if ncf >= 75
      return 'ncf75'
    else
      return 'mixed'

