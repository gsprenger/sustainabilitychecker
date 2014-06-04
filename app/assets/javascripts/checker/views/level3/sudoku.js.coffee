class window.SudokuView
  constructor: (@isOverlay) ->
    @$el = $("<div id='sudoku'>")
    $(window).on 'choicecomplete', =>
      @render()

  render: ->
    sudoku = App.get().sudoku
    c = App.get().content
    l = App.get().level
    success = sudoku.getSuccess()
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
          <td class='cell-number'>#{sudoku.get_TFOOD()}</td>
          <td class='cell-number'>#{sudoku.get_TET()}</td>
          <td class='cell-number'>#{sudoku.get_THA()}</td>
          <td class='cell-number'>#{sudoku.get_TLU()}</td>
          <td class='cell-number'>#{sudoku.get_EMR_WS()}</td>
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
          <td class='cell-number'>#{sudoku.diet.get_HH_food()}</td>
          <td class='cell-number'>#{sudoku.households.get_ET_HH()}</td>
          <td class='cell-number'>#{sudoku.demographics.get_HA_HH()}</td>
          <td class='cell-number'>negl.</td>
          <td class='cell-number'>#{sudoku.get_EMR_HH()}</td>
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
          <td class='cell-number'>#{sudoku.diet.get_SG_food()}</td>
          <td class='cell-number'>#{sudoku.services.get_ET_SG()}</td>
          <td class='cell-number'>#{sudoku.services.get_HA_SG()}</td>
          <td class='cell-number'>negl.</td>
          <td class='cell-number'>#{sudoku.get_EMR_SG()}</td>
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
          <td class='cell-number'>#{sudoku.diet.get_BM_food()}</td>
          <td class='cell-number'>#{sudoku.bm.get_ET_BM()}</td>
          <td class='cell-number'>#{sudoku.bm.get_HA_BM()}</td>
          <td class='cell-number'>negl.</td>
          <td class='cell-number'>#{sudoku.get_EMR_BM()}</td>
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
          <td class='cell-number'>#{sudoku.diet.get_AG_food()}</td>
          <td class='cell-number'>#{sudoku.agriculture.get_ET_AG()}</td>
          <td class='cell-number'>#{sudoku.agriculture.get_HA_AG()}</td>
          <td class='cell-number'>#{sudoku.agriculture.get_LU_AG()}</td>
          <td class='cell-number'>#{sudoku.get_EMR_AG()}</td>
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
          <td class='cell-number'>#{sudoku.energy.get_ET_EM()}</td>
          <td class='cell-number'>#{sudoku.energy.get_HA_EM()}</td>
          <td class='cell-number'>#{sudoku.energy.get_LU_EM()}</td>
          <td class='cell-number'>#{sudoku.get_EMR_EM()}</td>
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
          <td class='cell-number'>#{sudoku.get_DS_food()}</td>
          <td class='cell-number'>#{sudoku.get_DS_energy()}</td>
          <td class='cell-number'>8760</td>
          <td class='cell-number'>#{sudoku.get_DS_LU()}</td>
          <td class='cell-number'>#{sudoku.get_EMR_DS()}</td>
          <td class='cell-number'>#{sudoku.get_FMD_DS()}</td>
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
          <td class='cell-number'>#{sudoku.get_imports_food()}</td>
          <td class='cell-number'>#{sudoku.get_imports_energy()}</td>
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
          <td class='cell-number'>#{sudoku.get_vimports_HA()}</td>
          <td class='cell-number'>#{sudoku.get_vimports_LU()}</td>
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
