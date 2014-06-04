class window.SudokuView
  constructor: (@isOverlay) ->
    @$el = $("<div id='sudoku'>")
    $(window).on 'choicecomplete', =>
      @render()
      # flash new values
      if App.get().level >= 2
        changes = []
        if @TFOOD != @oldTFOOD
          changes.push({"TFOOD": [@oldTFOOD, @TFOOD]})
        if @TET != @oldTET
          changes.push({"TET": [@oldTET, @TET]})
        if @THA != @oldTHA
          changes.push({"THA": [@oldTHA, @THA]})
        if @TLU != @oldTLU
          changes.push({"TLU": [@oldTLU, @TLU]})
        if @EMR_WS != @oldEMR_WS
          changes.push({"EMR_WS": [@oldEMR_WS, @EMR_WS]})
        if @HH_food != @oldHH_food
          changes.push({"HH_food": [@oldHH_food, @HH_food]})
        if @ET_HH != @oldET_HH
          changes.push({"ET_HH": [@oldET_HH, @ET_HH]})
        if @HA_HH != @oldHA_HH
          changes.push({"HA_HH": [@oldHA_HH, @HA_HH]})
        if @EMR_HH != @oldEMR_HH
          changes.push({"EMR_HH": [@oldEMR_HH, @EMR_HH]})
        if @SG_food != @oldSG_food
          changes.push({"SG_food": [@oldSG_food, @SG_food]})
        if @ET_SG != @oldET_SG
          changes.push({"ET_SG": [@oldET_SG, @ET_SG]})
        if @HA_SG != @oldHA_SG
          changes.push({"HA_SG": [@oldHA_SG, @HA_SG]})
        if @EMR_SG != @oldEMR_SG
          changes.push({"EMR_SG": [@oldEMR_SG, @EMR_SG]})
        if @BM_food != @oldBM_food
          changes.push({"BM_food": [@oldBM_food, @BM_food]})
        if @ET_BM != @oldET_BM
          changes.push({"ET_BM": [@oldET_BM, @ET_BM]})
        if @HA_BM != @oldHA_BM
          changes.push({"HA_BM": [@oldHA_BM, @HA_BM]})
        if @EMR_BM != @oldEMR_BM
          changes.push({"EMR_BM": [@oldEMR_BM, @EMR_BM]})
        if @AG_food != @oldAG_food
          changes.push({"AG_food": [@oldAG_food, @AG_food]})
        if @ET_AG != @oldET_AG
          changes.push({"ET_AG": [@oldET_AG, @ET_AG]})
        if @HA_AG != @oldHA_AG
          changes.push({"HA_AG": [@oldHA_AG, @HA_AG]})
        if @LU_AG != @oldLU_AG
          changes.push({"LU_AG": [@oldLU_AG, @LU_AG]})
        if @EMR_AG != @oldEMR_AG
          changes.push({"EMR_AG": [@oldEMR_AG, @EMR_AG]})
        if @ET_EM != @oldET_EM
          changes.push({"ET_EM": [@oldET_EM, @ET_EM]})
        if @HA_EM != @oldHA_EM
          changes.push({"HA_EM": [@oldHA_EM, @HA_EM]})
        if @LU_EM != @oldLU_EM
          changes.push({"LU_EM": [@oldLU_EM, @LU_EM]})
        if @EMR_EM != @oldEMR_EM
          changes.push({"EMR_EM": [@oldEMR_EM, @EMR_EM]})
        if @DS_food != @oldDS_food
          changes.push({"DS_food": [@oldDS_food, @DS_food]})
        if @DS_energy != @oldDS_energy
          changes.push({"DS_energy": [@oldDS_energy, @DS_energy]})
        if @DS_LU != @oldDS_LU
          changes.push({"DS_LU": [@oldDS_LU, @DS_LU]})
        if @EMR_DS != @oldEMR_DS
          changes.push({"EMR_DS": [@oldEMR_DS, @EMR_DS]})
        if @FMD_DS != @oldFMD_DS
          changes.push({"FMD_DS": [@oldFMD_DS, @FMD_DS]})
        if @imports_food != @oldimports_food
          changes.push({"imports_food": [@oldimports_food, @imports_food]})
        if @imports_energy != @oldimports_energy
          changes.push({"imports_energy": [@oldimports_energy, @imports_energy]})
        if @vimports_HA != @oldvimports_HA
          changes.push({"vimports_HA": [@oldvimports_HA, @vimports_HA]})
        if @vimports_LU != @oldvimports_LU
          changes.push({"vimports_LU": [@oldvimports_LU, @vimports_LU]})
        # level 3: flash values
        if App.get().level == 3
          for e in changes
            for name, vals of e
              @$el.find('#'+name).css('background-color', 'gray')

  render: ->
    sudoku = App.get().sudoku
    c = App.get().content
    l = App.get().level
    success = sudoku.getSuccess()
    # get all variables and store previous val unless first time
    if @TFOOD?
      @oldTFOOD = @TFOOD
    @TFOOD = sudoku.get_TFOOD()
    if @TET?
      @oldTET = @TET
    @TET = sudoku.get_TET()
    if @THA?
      @oldTHA = @THA
    @THA = sudoku.get_THA()
    if @TLU?
      @oldTLU = @TLU
    @TLU = sudoku.get_TLU()
    if @EMR_WS?
      @oldEMR_WS = @EMR_WS
    @EMR_WS = sudoku.get_EMR_WS()
    if @HH_food?
      @oldHH_food = @HH_food
    @HH_food = sudoku.diet.get_HH_food()
    if @ET_HH?
      @oldET_HH = @ET_HH
    @ET_HH = sudoku.households.get_ET_HH()
    if @HA_HH?
      @oldHA_HH = @HA_HH
    @HA_HH = sudoku.demographics.get_HA_HH()
    if @EMR_HH?
      @oldEMR_HH = @EMR_HH
    @EMR_HH = sudoku.get_EMR_HH()
    if @SG_food?
      @oldSG_food = @SG_food
    @SG_food = sudoku.diet.get_SG_food()
    if @ET_SG?
      @oldET_SG = @ET_SG
    @ET_SG = sudoku.services.get_ET_SG()
    if @HA_SG?
      @oldHA_SG = @HA_SG
    @HA_SG = sudoku.services.get_HA_SG()
    if @EMR_SG?
      @oldEMR_SG = @EMR_SG
    @EMR_SG = sudoku.get_EMR_SG()
    if @BM_food?
      @oldBM_food = @BM_food
    @BM_food = sudoku.diet.get_BM_food()
    if @ET_BM?
      @oldET_BM = @ET_BM
    @ET_BM = sudoku.bm.get_ET_BM()
    if @HA_BM?
      @oldHA_BM = @HA_BM
    @HA_BM = sudoku.bm.get_HA_BM()
    if @EMR_BM?
      @oldEMR_BM = @EMR_BM
    @EMR_BM = sudoku.get_EMR_BM()
    if @AG_food?
      @oldAG_food = @AG_food
    @AG_food = sudoku.diet.get_AG_food()
    if @ET_AG?
      @oldET_AG = @ET_AG
    @ET_AG = sudoku.agriculture.get_ET_AG()
    if @HA_AG?
      @oldHA_AG = @HA_AG
    @HA_AG = sudoku.agriculture.get_HA_AG()
    if @LU_AG?
      @oldLU_AG = @LU_AG
    @LU_AG = sudoku.agriculture.get_LU_AG()
    if @EMR_AG?
      @oldEMR_AG = @EMR_AG
    @EMR_AG = sudoku.get_EMR_AG()
    if @ET_EM?
      @oldET_EM = @ET_EM
    @ET_EM = sudoku.energy.get_ET_EM()
    if @HA_EM?
      @oldHA_EM = @HA_EM
    @HA_EM = sudoku.energy.get_HA_EM()
    if @LU_EM?
      @oldLU_EM = @LU_EM
    @LU_EM = sudoku.energy.get_LU_EM()
    if @EMR_EM?
      @oldEMR_EM = @EMR_EM
    @EMR_EM = sudoku.get_EMR_EM()
    if @DS_food?
      @oldDS_food = @DS_food
    @DS_food = sudoku.get_DS_food()
    if @DS_energy?
      @oldDS_energy = @DS_energy
    @DS_energy = sudoku.get_DS_energy()
    if @DS_LU?
      @oldDS_LU = @DS_LU
    @DS_LU = sudoku.get_DS_LU()
    if @EMR_DS?
      @oldEMR_DS = @EMR_DS
    @EMR_DS = sudoku.get_EMR_DS()
    if @FMD_DS?
      @oldFMD_DS = @FMD_DS
    @FMD_DS = sudoku.get_FMD_DS()
    if @imports_food?
      @oldimports_food = @imports_food
    @imports_food = sudoku.get_imports_food()
    if @imports_energy?
      @oldimports_energy = @imports_energy
    @imports_energy = sudoku.get_imports_energy()
    if @vimports_HA?
      @oldvimports_HA = @vimports_HA
    @vimports_HA = sudoku.get_vimports_HA()
    if @vimports_LU?
      @oldvimports_LU = @vimports_LU
    @vimports_LU = sudoku.get_vimports_LU()

    html =
      """
      <table>
        <tr>
          <td colspan="2" rowspan="2" id='topcell' class='#{if success then 'success' else 'failure'}'>
            #{if success then 'Sustainable' else 'Unsustainable'}
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
          <td class='cell-header cell-flowfund'>
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
          <td class='cell-header cell-flowfund'>
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
          <td class='cell-header cell-flowfund'>
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
          <td class='cell-header cell-flowfund'>
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
          <td class='cell-header cell-flowfund'>
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
          <td class='cell-header cell-flowfund'>
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
          <td class='cell-header'>
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
          <td class='cell-header'>
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
          <td class='cell-header'>
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
          <td class='cell-header'>
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
          <td class='cell-header'>
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
          <td class='cell-header'>
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
          <td class='cell-header'>
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
          <td class='cell-header'>
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
          <td class='cell-header'>
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
    return this

  events: ->
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
