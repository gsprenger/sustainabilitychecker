class window.SudokuView
  indexHeaders: {
    "TFOOD": ["hfood", "hws"],
    "TET": ["henergy", "hws"],
    "THA": ["hha", "hws"],
    "TLU": ["hlu", "hws"],
    "EMR_WS": ["hemr", "hws"],
    "HH_food": ["hfood", "hhh"],
    "ET_HH": ["henergy", "hhh"],
    "HA_HH": ["hha", "hhh"],
    "EMR_HH": ["hemr", "hhh"],
    "SG_food": ["hfood", "hsg"],
    "ET_SG": ["henergy", "hsg"],
    "HA_SG": ["hha", "hsg"],
    "EMR_SG": ["hemr", "hsg"],
    "BM_food": ["hfood", "hbm"],
    "ET_BM": ["henergy", "hbm"],
    "HA_BM": ["hha", "hbm"],
    "EMR_BM": ["hemr", "hbm"],
    "AG_food": ["hfood", "hag"],
    "ET_AG": ["henergy", "hag"],
    "HA_AG": ["hha", "hag"],
    "LU_AG": ["hlu", "hag"],
    "EMR_AG": ["hemr", "hag"],
    "ET_EM": ["henergy", "hem"],
    "HA_EM": ["hha", "hem"],
    "LU_EM": ["hlu", "hem"],
    "EMR_EM": ["hemr", "hem"],
    "DS_food": ["hfood", "hds"],
    "DS_energy": ["henergy", "hds"],
    "DS_LU": ["hlu", "hds"],
    "EMR_DS": ["hemr", "hds"],
    "FMD_DS": ["hfmd", "hds"],
    "imports_food": ["hfood", "himports"],
    "imports_energy": ["henergy", "himports"],
    "vimports_HA": ["hha", "hvimports"],
    "vimports_LU": ["hlu", "hvimports"],
  }

  constructor: (@isOverlay) ->
    @$el = $("<div id='sudoku'>")
    # init variables
    @firstTimeSustainable = false
    @firstRender = true
    # get all value cells name
    @valueNames = []
    for k of @indexHeaders
      @valueNames.push(k)
    # When user makes a choice, update sudoku and flash cells
    if App.get().level >= 2
      $(window).on 'choicecomplete', =>
        @render()
        # flash new values
        changes = {}
        # if new values are found, store them in changes array
        for name in @valueNames
          if @[name] != @['old'+name]
            changes[name] = [@['old'+name], @[name]]
        changed = false
        for c of changes
          changed = true 
          break
        if changed
          delay = if $('#lvl3-main').hasClass('out') then 10 else 1000
          $(window).trigger 'opensudokuoverlay'
          setTimeout =>
            # level 3: flash values
            if App.get().level == 3
              overlayToggled = false
              for name, vals of changes
                color = (if @success then '#5CB85C' else '#D9534F')
                @flashCell(name, 3, color, '#fff')
            # level 2: flash headers
            if App.get().level == 2
              overlayToggled = false
              for name, vals of changes
                @flashCell(@indexHeaders[name][0], 3, '#eee')
                @flashCell(@indexHeaders[name][1], 3, '#eee')
            if @success != @oldSuccess
              @flashCell('topcell', 3, (if @success then '#5CB85C' else '#D9534F'), '#fff', true)
          , delay

  render: ->
    sudoku = App.get().sudoku
    c = App.get().content
    l = App.get().level
    if @success?
      @oldSuccess = @success
    @success = sudoku.getSuccess()
    # first time sustainable in level 3 = show check
    if l == 3
      if !@firstTimeSustainable && @success && !@firstRender
        $('body,html').stop(true,true).animate({scrollTop: $('#check').offset().top}, 500)
        @firstTimeSustainable = true
    # store previous val
    for name in @valueNames
      if @[name]?
        @['old'+name] = @[name]
    # get all variables from Sudoku model
    @TFOOD = sudoku.get_TFOOD()
    @TET = sudoku.get_TET()
    @THA = sudoku.get_THA()
    @TLU = sudoku.get_TLU()
    @EMR_WS = sudoku.get_EMR_WS()
    @HH_food = sudoku.diet.get_HH_food()
    @ET_HH = sudoku.households.get_ET_HH()
    @HA_HH = sudoku.demographics.get_HA_HH()
    @EMR_HH = sudoku.get_EMR_HH()
    @SG_food = sudoku.diet.get_SG_food()
    @ET_SG = sudoku.services.get_ET_SG()
    @HA_SG = sudoku.services.get_HA_SG()
    @EMR_SG = sudoku.get_EMR_SG()
    @BM_food = sudoku.diet.get_BM_food()
    @ET_BM = sudoku.bm.get_ET_BM()
    @HA_BM = sudoku.bm.get_HA_BM()
    @EMR_BM = sudoku.get_EMR_BM()
    @AG_food = sudoku.diet.get_AG_food()
    @ET_AG = sudoku.agriculture.get_ET_AG()
    @HA_AG = sudoku.agriculture.get_HA_AG()
    @LU_AG = sudoku.agriculture.get_LU_AG()
    @EMR_AG = sudoku.get_EMR_AG()
    @ET_EM = sudoku.energy.get_ET_EM()
    @HA_EM = sudoku.energy.get_HA_EM()
    @LU_EM = sudoku.energy.get_LU_EM()
    @EMR_EM = sudoku.get_EMR_EM()
    @DS_food = sudoku.get_DS_food()
    @DS_energy = sudoku.get_DS_energy()
    @DS_LU = sudoku.get_DS_LU()
    @EMR_DS = sudoku.get_EMR_DS()
    @FMD_DS = sudoku.get_FMD_DS()
    @imports_food = sudoku.get_imports_food()
    @imports_energy = sudoku.get_imports_energy()
    @vimports_HA = sudoku.get_vimports_HA()
    @vimports_LU = sudoku.get_vimports_LU()
    html =
      """
      <table>
        <tr>
          <td colspan="2" rowspan="2" id='topcell' class='#{if @success then 'success' else 'failure'}'>
            #{if @success then 'Sustainable' else 'Unsustainable'}
          </td>
          <td colspan="2" class='cell-header'>
            <strong>Flows</strong>
            <i class='fa fa-info-circle'></i>
            <div class='popover'>
              <div class='popover-title'>
                #{c.text('chkr_sud_flows_t')}
              </div>
              <div class='popover-content'>
                #{c.text('chkr_sud_flows_c')}
              </div>
            </div>
          </td>
          <td colspan="2" class='cell-header'>
            <strong>Funds</strong>
            <i class='fa fa-info-circle'></i>
            <div class='popover'>
              <div class='popover-title'>
                #{c.text('chkr_sud_funds_t')}
              </div>
              <div class='popover-content'>
                #{c.text('chkr_sud_funds_c')}
              </div>
            </div>
          </td>
          <td colspan="2" class='cell-header'>
            <strong>Flow/Fund</strong>
            <i class='fa fa-info-circle'></i>
            <div class='popover'>
              <div class='popover-title'>
                #{c.text('chkr_sud_flowfund_t')}
              </div>
              <div class='popover-content'>
                #{c.text('chkr_sud_flowfund_c')}
              </div>
            </div>
          </td>
        </tr>
        <tr>
          <td class='cell-header cell-flowfund' id='hfood'>
            <strong>Food</strong>
            <i class='fa fa-info-circle'></i><br>
            (kg grain-equiv p.c.)
            <div class='popover'>
              <div class='popover-title'>
                #{c.text('chkr_sud_food_t')}
              </div>
              <div class='popover-content'>
                #{c.text('chkr_sud_food_c')}
              </div>
            </div>
          </td>
          <td class='cell-header cell-flowfund' id='henergy'>
            <strong>Energy</strong>
            <i class='fa fa-info-circle'></i><br>
            (GJ-GER p.c.)
            <div class='popover'>
              <div class='popover-title'>
                #{c.text('chkr_sud_energy_t')}
              </div>
              <div class='popover-content'>
                #{c.text('chkr_sud_energy_c')}
              </div>
            </div>
          </td>
          <td class='cell-header cell-flowfund' id='hha'>
            <strong>Human Activity</strong>
            <i class='fa fa-info-circle'></i><br>
            (hrs p.c.)
            <div class='popover'>
              <div class='popover-title'>
                #{c.text('chkr_sud_ha_t')}
              </div>
              <div class='popover-content'>
                #{c.text('chkr_sud_ha_c')}
              </div>
            </div>
          </td>
          <td class='cell-header cell-flowfund' id='hlu'>
            <strong>Land Use</strong>
            <i class='fa fa-info-circle'></i><br>
            (ha p.c.)
            <div class='popover'>
              <div class='popover-title'>
                #{c.text('chkr_sud_lu_t')}
              </div>
              <div class='popover-content'>
                #{c.text('chkr_sud_lu_c')}
              </div>
            </div>
          </td>
          <td class='cell-header cell-flowfund' id='hemr'>
            <strong>Energy Metabolic Rate</strong>
            <i class='fa fa-info-circle'></i><br>
            (MJ/hrs)
            <div class='popover'>
              <div class='popover-title'>
                #{c.text('chkr_sud_emr_t')}
              </div>
              <div class='popover-content'>
                #{c.text('chkr_sud_emr_c')}
              </div>
            </div>
          </td>
          <td class='cell-header cell-flowfund' id='hfmd'>
            <strong>Food Metabolic Density</strong>
            <i class='fa fa-info-circle'></i><br>
            (kg grains-equiv/ha)
            <div class='popover'>
              <div class='popover-title'>
                #{c.text('chkr_sud_fmd_t')}
              </div>
              <div class='popover-content'>
                #{c.text('chkr_sud_fmd_c')}
              </div>
            </div>
          </td>
        </tr>
        <tr>
          <td rowspan="6" class='cell-header'>
            <strong>Consumption</strong>
            <i class='fa fa-info-circle'></i>
            <div class='popover'>
              <div class='popover-title'>
                #{c.text('chkr_sud_consumption_t')}
              </div>
              <div class='popover-content'>
                #{c.text('chkr_sud_consumption_c')}
              </div>
            </div>
          </td>
          <td class='cell-header' id='hws'>
            <i class='fa fa-info-circle'></i>
            <strong>Whole society</strong>
            <div class='popover'>
              <div class='popover-title'>
                #{c.text('chkr_sud_ws_t')}
              </div>
              <div class='popover-content'>
                #{c.text('chkr_sud_ws_c')}
              </div>
            </div>
          </td>
          <td id='TFOOD' class='cell-number'>#{@TFOOD}</td>
          <td id='TET' class='cell-number'>#{@TET}</td>
          <td id='THA' class='cell-number'>#{@THA}</td>
          <td id='TLU' class='cell-number'>#{@TLU}</td>
          <td id='EMR_WS' class='cell-number'>#{@EMR_WS}</td>
          <td class='cell-number'>N/A</td>
        </tr>
        <tr>
          <td class='cell-header' id='hhh'>
            <i class='fa fa-info-circle'></i>
            <strong>Households</strong>
            <div class='popover'>
              <div class='popover-title'>
                #{c.text('chkr_sud_hh_t')}
              </div>
              <div class='popover-content'>
                #{c.text('chkr_sud_hh_c')}
              </div>
            </div>
          </td>
          <td id='HH_food' class='cell-number'>#{@HH_food}</td>
          <td id='ET_HH' class='cell-number'>#{@ET_HH}</td>
          <td id='HA_HH' class='cell-number'>#{@HA_HH}</td>
          <td class='cell-number'>negl.</td>
          <td id='EMR_HH' class='cell-number'>#{@EMR_HH}</td>
          <td class='cell-number'>N/A</td>
        </tr>
        <tr>
          <td class='cell-header' id='hsg'>
            <i class='fa fa-info-circle'></i>
            <strong>Services and government</strong>
            <div class='popover'>
              <div class='popover-title'>
                #{c.text('chkr_sud_sg_t')}
              </div>
              <div class='popover-content'>
                #{c.text('chkr_sud_sg_c')}
              </div>
            </div>
          </td>
          <td id='SG_food' class='cell-number'>#{@SG_food}</td>
          <td id='ET_SG' class='cell-number'>#{@ET_SG}</td>
          <td id='HA_SG' class='cell-number'>#{@HA_SG}</td>
          <td class='cell-number'>negl.</td>
          <td id='EMR_SG' class='cell-number'>#{@EMR_SG}</td>
          <td class='cell-number'>N/A</td>
        </tr>
        <tr>
          <td class='cell-header' id='hbm'>
            <i class='fa fa-info-circle'></i>
            <strong>Building and manufacturing</strong>
            <div class='popover'>
              <div class='popover-title'>
                #{c.text('chkr_sud_bm_t')}
              </div>
              <div class='popover-content'>
                #{c.text('chkr_sud_bm_c')}
              </div>
            </div>
          </td>
          <td id='BM_food' class='cell-number'>#{@BM_food}</td>
          <td id='ET_BM' class='cell-number'>#{@ET_BM}</td>
          <td id='HA_BM' class='cell-number'>#{@HA_BM}</td>
          <td class='cell-number'>negl.</td>
          <td id='EMR_BM' class='cell-number'>#{@EMR_BM}</td>
          <td class='cell-number'>N/A</td>
        </tr>
        <tr>
          <td class='cell-header' id='hag'>
            <i class='fa fa-info-circle'></i>
            <strong>Agriculture</strong>
            <div class='popover'>
              <div class='popover-title'>
                #{c.text('chkr_sud_ag_t')}
              </div>
              <div class='popover-content'>
                #{c.text('chkr_sud_ag_c')}
              </div>
            </div>
          </td>
          <td id='AG_food' class='cell-number'>#{@AG_food}</td>
          <td id='ET_AG' class='cell-number'>#{@ET_AG}</td>
          <td id='HA_AG' class='cell-number'>#{@HA_AG}</td>
          <td id='LU_AG' class='cell-number'>#{@LU_AG}</td>
          <td id='EMR_AG' class='cell-number'>#{@EMR_AG}</td>
          <td class='cell-number'>N/A</td>
        </tr>
        <tr>
          <td class='cell-header' id='hem'>
            <i class='fa fa-info-circle'></i>
            <strong>Energy and mining</strong>
            <div class='popover'>
              <div class='popover-title'>
                #{c.text('chkr_sud_em_t')}
              </div>
              <div class='popover-content'>
                #{c.text('chkr_sud_em_c')}
              </div>
            </div>
          </td>
          <td class='cell-number'>N/A</td>
          <td id='ET_EM' class='cell-number'>#{@ET_EM}</td>
          <td id='HA_EM' class='cell-number'>#{@HA_EM}</td>
          <td id='LU_EM' class='cell-number'>#{@LU_EM}</td>
          <td id='EMR_EM' class='cell-number'>#{@EMR_EM}</td>
          <td class='cell-number'>N/A</td>
        </tr>
        <tr>
          <td colspan="8"></td>
        </tr>
        <tr>
          <td rowspan="3" class='cell-header'>
            <strong>Supply</strong>
            <i class='fa fa-info-circle'></i>
            <div class='popover'>
              <div class='popover-title'>
                #{c.text('chkr_sud_supply_t')}
              </div>
              <div class='popover-content'>
                #{c.text('chkr_sud_supply_c')}
              </div>
            </div>
          </td>
          <td class='cell-header' id='hds'>
            <i class='fa fa-info-circle'></i>
            <strong>Domestic Supply</strong>
            <div class='popover'>
              <div class='popover-title'>
                #{c.text('chkr_sud_domsup_t')}
              </div>
              <div class='popover-content'>
                #{c.text('chkr_sud_domsup_c')}
              </div>
            </div>
          </td>
          <td id='DS_food' class='cell-number'>#{@DS_food}</td>
          <td id='DS_energy' class='cell-number'>#{@DS_energy}</td>
          <td class='cell-number'>8760</td>
          <td id='DS_LU' class='cell-number'>#{@DS_LU}</td>
          <td id='EMR_DS' class='cell-number'>#{@EMR_DS}</td>
          <td id='FMD_DS' class='cell-number'>#{@FMD_DS}</td>
        </tr>
        <tr>
          <td class='cell-header' id='himports'>
            <i class='fa fa-info-circle'></i>
            <strong>Imports</strong>
            <div class='popover'>
              <div class='popover-title'>
                #{c.text('chkr_sud_imports_t')}
              </div>
              <div class='popover-content'>
                #{c.text('chkr_sud_imports_c')}
              </div>
            </div>
          </td>
          <td id='imports_food' class='cell-number'>#{@imports_food}</td>
          <td id='imports_energy' class='cell-number'>#{@imports_energy}</td>
          <td class='cell-number'>N/A</td>
          <td class='cell-number'>N/A</td>
          <td class='cell-number'>N/A</td>
          <td class='cell-number'>N/A</td>
        </tr>
        <tr>
          <td class='cell-header' id='hvimports'>
            <i class='fa fa-info-circle'></i>
            <strong>Virtual Imports</strong>
            <div class='popover'>
              <div class='popover-title'>
                #{c.text('chkr_sud_vimports_t')}
              </div>
              <div class='popover-content'>
                #{c.text('chkr_sud_vimports_c')}
              </div>
            </div>
          </td>
          <td class='cell-number'>N/A</td>
          <td class='cell-number'>N/A</td>
          <td id='vimports_HA' class='cell-number'>#{@vimports_HA}</td>
          <td id='vimports_LU' class='cell-number'>#{@vimports_LU}</td>
          <td class='cell-number'>N/A</td>
          <td class='cell-number'>N/A</td>
        </tr>
      </table>
      <div #{if @isOverlay then "class='text-center'"}>
        <em>(Numbers may not add up due to rounding)</em>
      </div>
      """
    if App.get().isMercury
      html += """
        <h3>(Editor only) Sudoku info pop-up:</h3>
        <div class='panel panel-default'>
          <div class='panel-heading'>
            #{c.text('chkr_sud_flows_t')}
          </div>
          <div class='panel-body'>
            #{c.text('chkr_sud_flows_c')}
          </div>
        </div>
        <div class='panel panel-default'>
          <div class='panel-heading'>
            #{c.text('chkr_sud_funds_t')}
          </div>
          <div class='panel-body'>
            #{c.text('chkr_sud_funds_c')}
          </div>
        </div>
        <div class='panel panel-default'>
          <div class='panel-heading'>
            #{c.text('chkr_sud_flowfund_t')}
          </div>
          <div class='panel-body'>
            #{c.text('chkr_sud_flowfund_c')}
          </div>
        </div>
        <div class='panel panel-default'>
          <div class='panel-heading'>
            #{c.text('chkr_sud_food_t')}
          </div>
          <div class='panel-body'>
            #{c.text('chkr_sud_food_c')}
          </div>
        </div>
        <div class='panel panel-default'>
          <div class='panel-heading'>
            #{c.text('chkr_sud_energy_t')}
          </div>
          <div class='panel-body'>
            #{c.text('chkr_sud_energy_c')}
          </div>
        </div>
        <div class='panel panel-default'>
          <div class='panel-heading'>
            #{c.text('chkr_sud_ha_t')}
          </div>
          <div class='panel-body'>
            #{c.text('chkr_sud_ha_c')}
          </div>
        </div>
        <div class='panel panel-default'>
          <div class='panel-heading'>
            #{c.text('chkr_sud_lu_t')}
          </div>
          <div class='panel-body'>
            #{c.text('chkr_sud_lu_c')}
          </div>
        </div>
        <div class='panel panel-default'>
          <div class='panel-heading'>
            #{c.text('chkr_sud_emr_t')}
          </div>
          <div class='panel-body'>
            #{c.text('chkr_sud_emr_c')}
          </div>
        </div>
        <div class='panel panel-default'>
          <div class='panel-heading'>
            #{c.text('chkr_sud_fmd_t')}
          </div>
          <div class='panel-body'>
            #{c.text('chkr_sud_fmd_c')}
          </div>
        </div>
        <div class='panel panel-default'>
          <div class='panel-heading'>
            #{c.text('chkr_sud_consumption_t')}
          </div>
          <div class='panel-body'>
            #{c.text('chkr_sud_consumption_c')}
          </div>
        </div>
        <div class='panel panel-default'>
          <div class='panel-heading'>
            #{c.text('chkr_sud_ws_t')}
          </div>
          <div class='panel-body'>
            #{c.text('chkr_sud_ws_c')}
          </div>
        </div>
        <div class='panel panel-default'>
          <div class='panel-heading'>
            #{c.text('chkr_sud_hh_t')}
          </div>
          <div class='panel-body'>
            #{c.text('chkr_sud_hh_c')}
          </div>
        </div>
        <div class='panel panel-default'>
          <div class='panel-heading'>
            #{c.text('chkr_sud_sg_t')}
          </div>
          <div class='panel-body'>
            #{c.text('chkr_sud_sg_c')}
          </div>
        </div>
        <div class='panel panel-default'>
          <div class='panel-heading'>
            #{c.text('chkr_sud_bm_t')}
          </div>
          <div class='panel-body'>
            #{c.text('chkr_sud_bm_c')}
          </div>
        </div>
        <div class='panel panel-default'>
          <div class='panel-heading'>
            #{c.text('chkr_sud_ag_t')}
          </div>
          <div class='panel-body'>
            #{c.text('chkr_sud_ag_c')}
          </div>
        </div>
        <div class='panel panel-default'>
          <div class='panel-heading'>
            #{c.text('chkr_sud_em_t')}
          </div>
          <div class='panel-body'>
            #{c.text('chkr_sud_em_c')}
          </div>
        </div>
        <div class='panel panel-default'>
          <div class='panel-heading'>
            #{c.text('chkr_sud_supply_t')}
          </div>
          <div class='panel-body'>
            #{c.text('chkr_sud_supply_c')}
          </div>
        </div>
        <div class='panel panel-default'>
          <div class='panel-heading'>
            #{c.text('chkr_sud_domsup_t')}
          </div>
          <div class='panel-body'>
            #{c.text('chkr_sud_domsup_c')}
          </div>
        </div>
        <div class='panel panel-default'>
          <div class='panel-heading'>
            #{c.text('chkr_sud_imports_t')}
          </div>
          <div class='panel-body'>
            #{c.text('chkr_sud_imports_c')}
          </div>
        </div>
        <div class='panel panel-default'>
          <div class='panel-heading'>
            #{c.text('chkr_sud_vimports_t')}
          </div>
          <div class='panel-body'>
            #{c.text('chkr_sud_vimports_c')}
          </div>
        </div>
      """
    @$el.html(html)
    # precision -> 2
    @$el.find('td').each (i, td) ->
      val = $(td).text()
      if (val != "" && !isNaN(val))
        $(td).text(+(+val).toPrecision(2))
        if ($(td).text() == '0')
          $(td).text('negl.')
    @events()
    @firstRender = false
    return this

  events: ->
    # Init info popovers
    @$el.find('.fa-info-circle').popover({
      placement: 'bottom',
      trigger: 'hover',
      container: 'body'
      html: true,
      title: ->
        $(event.target).nextAll('.popover').find('.popover-title').html()
      , content: ->
        $(event.target).nextAll('.popover').find('.popover-content').html()
    })
    @$el.find('.fa-info-circle').on 'click', ->
      $(this).popover('toggle')

  flashCell: (cellID, times, color, textColor, preventStay) ->
    originalColor = @$el.find('#'+cellID).css('background-color')
    originalTextColor = @$el.find('#'+cellID).css('color')
    textColor = if textColor? then textColor else originalTextColor
    @recursiveFlashCell(cellID, times, color, textColor, originalColor, originalTextColor, preventStay)

  recursiveFlashCell: (cellID, times, color, textColor, originalColor, originalTextColor, preventStay) ->
    if times > 0
      setTimeout =>
        @$el.find('#'+cellID).css({backgroundColor: color, color: textColor})
        setTimeout =>
          @$el.find('#'+cellID).css({backgroundColor: originalColor, color: originalTextColor})
          @recursiveFlashCell(cellID, --times, color, textColor, originalColor, originalTextColor, preventStay)
        , 250
      , 250
    if times == 0 && !preventStay
      @$el.find('#'+cellID).css({backgroundColor: color, color: textColor})
