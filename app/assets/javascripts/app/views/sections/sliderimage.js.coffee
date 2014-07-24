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
          contextSlug = @getHHContextSlug(data)
        # services
        else if data.section == 'd_ser'
          contextSlug = @getSGContextSlug(data)
        # elec
        else if data.section == 's_ene' && data.slidergroup == 'ele'
          contextSlug = @getElecContextSlug(data)
        # fuels
        else if data.section == 's_ene' && data.slidergroup == 'fue'
          contextSlug = @getFuelsContextSlug(data)
        # Now we got the data, update img
        c = App.get().content
        p = @section.i18nPrefix + (if @slidergroupSlug then @slidergroupSlug else '')
        prefix = "sligm_#{p}_#{contextSlug}_"
        $img.attr('src', "#{c.text(prefix+'img', 'none')}")
        $img.attr('title', "#{c.text(prefix+'imgcred', 'none')}")
        $desc.html("<div class='desc'>#{c.text(prefix+'desc', 'none')}</div><div class='descsub'><small>#{c.text(prefix+'descsub', 'none')}</small></div>")

  getHHContextSlug:(data) ->
    # get values. Since we're doing it while sliding it is not possible to get the value
    # of the sliding slider directly. Have to get it from event data.
    sudokuModel = App.get().sudoku
    urb = (if data && data.slider == 'd_hou_urb' then data.value else sudokuModel.households.get_urb())
    sub = (if data && data.slider == 'd_hou_sub' then data.value else sudokuModel.households.get_sub())
    apa = (if data && data.slider == 'd_hou_apa' then data.value else sudokuModel.households.get_apa())
    slu = sudokuModel.households.get_slu()
    #console.log("Household image update! urb#{urb} sub#{sub} apa#{apa}")
    prop = if urb == 30 then 'l' else if urb == 50 then 'h' else ''
    @contextSlug = "#{sub}-#{apa}-#{slu}#{prop}"

  getSGContextSlug:(data) ->
    sudokuModel = App.get().sudoku
    edu = (if data && data.slider == 'd_ser_edu' then data.value+1 else sudokuModel.services.get_edu())
    med = (if data && data.slider == 'd_ser_med' then data.value+1 else sudokuModel.services.get_med())
    pub = (if data && data.slider == 'd_ser_pub' then data.value+1 else sudokuModel.services.get_pub())
    tra = (if data && data.slider == 'd_ser_tra' then data.value+1 else sudokuModel.services.get_tra())
    #console.log("Services image update! edu#{edu} med#{med} pub#{pub} tra#{tra}")
    total = edu + med + pub + tra
    if total > 9
      @contextSlug =  'high'
    else if total > 6
      @contextSlug =  'med'
    else
      @contextSlug =  'low'

  getElecContextSlug:(data) ->
    sudokuModel = App.get().sudoku
    nuc = (if data && data.slider == 's_ene_nuc' then data.value else sudokuModel.energy.get_nuc())
    hyd = (if data && data.slider == 's_ene_hyd' then data.value else sudokuModel.energy.get_hyd())
    win = (if data && data.slider == 's_ene_win' then data.value else sudokuModel.energy.get_win())
    pho = (if data && data.slider == 's_ene_pho' then data.value else sudokuModel.energy.get_pho())
    csp = (if data && data.slider == 's_ene_csp' then data.value else sudokuModel.energy.get_csp())
    #console.log("Energy Elec image update! nuc#{nuc} hyd#{hyd} win#{win} pho#{pho} csp#{csp}")
    if nuc == 100
      @contextSlug =  'nuc100'
    else if hyd == 100
      @contextSlug =  'hyd100'
    else if win == 100
      @contextSlug =  'win100'
    else if pho == 100
      @contextSlug =  'pho100'
    else if csp == 100
      @contextSlug =  'csp100'
    else if nuc >= 75
      @contextSlug =  'nuc75'
    else if hyd >= 75
      @contextSlug =  'hyd75'
    else if nuc == 0
      @contextSlug =  'nuc0'
    else
      @contextSlug =  'mixed'

  getFuelsContextSlug:(data) ->
    sudokuModel = App.get().sudoku
    bio = (if data && data.slider == 's_ene_bio' then data.value else sudokuModel.energy.get_bio())
    hyg = (if data && data.slider == 's_ene_hyg' then data.value else sudokuModel.energy.get_hyg())
    ncf = (if data && data.slider == 's_ene_ncf' then data.value else sudokuModel.energy.get_ncf())
    #console.log("Energy Fuel image update! bio#{bio} hyg#{hyg} ncf#{ncf}")
    if bio >= 75
      @contextSlug =  'bio75'
    else if hyg >= 75
      @contextSlug =  'hyg75'
    else if ncf >= 75
      @contextSlug =  'ncf75'
    else
      @contextSlug =  'mixed'

