class window.SudokuView
  constructor: ->
    @$el = $("<div id='sudoku'>")
    @isRendered = false
    $(window).on 'choicecomplete', =>
      if (@$el.parent().hasClass('out'))
        @render()
      else
        @isRendered = false

  render: ->
    sudoku = App.get().sudoku
    console.log('render!')
    html =
      """
      <div class='text-center'>
        <em>(Numbers may not add up due to rounding)</em>
      </div>
      <table>
        <tr>
          <td colspan="2" rowspan="2"></td>
          <td colspan="2"><strong>Flows</strong></td>
          <td colspan="2"><strong>Funds</strong></td>
          <td colspan="2"><strong>Flow/Fund</strong> (Benchmarks)</td>
        </tr>
        <tr>
          <td>
            <strong>Food</strong><br>
            (kg grain-equiv p.c.)
          </td>
          <td>
            <strong>Energy</strong><br>
            (GJ-GER p.c.)
          </td>
          <td>
            <strong>Human Activity</strong><br>
            (hrs p.c.)
          </td>
          <td>
            <strong>Land Use</strong><br>
            (ha p.c.)
          </td>
          <td>
            <strong>Energy Metabolic Rate</strong><br>
            (MJ/hrs)
          </td>
          <td>
            <strong>Food Metabolic Density</strong><br>
            (kg grains-equiv/ha)
          </td>
        </tr>
        <tr>
          <td rowspan="6">Consumption</td>
          <td>Whole society</td>
          <td>#{sudoku.get_TFOOD()}</td>
          <td>#{sudoku.get_TET()}</td>
          <td>#{sudoku.get_THA()}</td>
          <td>#{sudoku.get_TLU()}</td>
          <td>#{sudoku.get_EMR_WS()}</td>
          <td>N/A</td>
        </tr>
        <tr>
          <td>Households</td>
          <td>#{sudoku.diet.get_HH_food()}</td>
          <td>#{sudoku.households.get_ET_HH()}</td>
          <td>#{sudoku.demographics.get_HA_HH()}</td>
          <td>negl.</td>
          <td>#{sudoku.get_EMR_HH()}</td>
          <td>N/A</td>
        </tr>
        <tr>
          <td>Services and government</td>
          <td>#{sudoku.diet.get_SG_food()}</td>
          <td>#{sudoku.services.get_ET_SG()}</td>
          <td>#{sudoku.services.get_HA_SG()}</td>
          <td>negl.</td>
          <td>#{sudoku.get_EMR_SG()}</td>
          <td>N/A</td>
        </tr>
        <tr>
          <td>Building and manufacturing</td>
          <td>#{sudoku.diet.get_BM_food()}</td>
          <td>#{sudoku.bm.get_ET_BM()}</td>
          <td>#{sudoku.bm.get_HA_BM()}</td>
          <td>negl.</td>
          <td>#{sudoku.get_EMR_BM()}</td>
          <td>N/A</td>
        </tr>
        <tr>
          <td>Agriculture</td>
          <td>#{sudoku.diet.get_AG_food()}</td>
          <td>#{sudoku.agriculture.get_ET_AG()}</td>
          <td>#{sudoku.agriculture.get_HA_AG()}</td>
          <td>#{sudoku.agriculture.get_LU_AG()}</td>
          <td>#{sudoku.get_EMR_AG()}</td>
          <td>N/A</td>
        </tr>
        <tr>
          <td>Energy and mining</td>
          <td>N/A</td>
          <td>#{sudoku.energy.get_ET_EM()}</td>
          <td>#{sudoku.energy.get_HA_EM()}</td>
          <td>#{sudoku.energy.get_LU_EM()}</td>
          <td>#{sudoku.get_EMR_EM()}</td>
          <td>N/A</td>
        </tr>
        <tr>
          <td colspan="8"></td>
        </tr>
        <tr>
          <td rowspan="3">Supply</td>
          <td>Domestic Supply</td>
          <td>#{sudoku.get_DS_food()}</td>
          <td>#{sudoku.get_DS_energy()}</td>
          <td>8760</td>
          <td>#{sudoku.get_DS_LU()}</td>
          <td>#{sudoku.get_EMR_DS()}</td>
          <td>#{sudoku.get_FMD_DS()}</td>
        </tr>
        <tr>
          <td>Imports</td>
          <td>#{sudoku.get_imports_food()}</td>
          <td>#{sudoku.get_imports_energy()}</td>
          <td>N/A</td>
          <td>N/A</td>
          <td>N/A</td>
          <td>N/A</td>
        </tr>
        <tr>
          <td>Virtual Imports</td>
          <td>N/A</td>
          <td>N/A</td>
          <td>#{sudoku.get_vimports_HA()}</td>
          <td>#{sudoku.get_vimports_LU()}</td>
          <td>N/A</td>
          <td>N/A</td>
        </tr>
      </table>
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
    @isRendered = true
    return this

  events: ->
