class window.SudokuView
  constructor:(@sudoku) ->
    @$el = $("<div class='sudoku'>")
    @sudoku = App.get().sudoku
    $(window).on 'choicecomplete', =>
      @render()

  render: ->
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
          <td colspan="2"><strong>Fund/Flow</strong></td>
        </tr>
        <tr>
          <td><strong>Food (kg grain-equiv p.c.)</strong></td>
          <td><strong>Energy (GJ-GER p.c.)</strong></td>
          <td><strong>HA (hrs p.c.)</strong></td>
          <td><strong>LU (ha p.c.)</strong></td>
          <td><strong>EMR (MJ/hrs)</strong></td>
          <td><strong>FMD (kg grains-equiv/ha)</strong></td>
        </tr>
        <tr>
          <td rowspan="6">Consumption</td>
          <td>WS</td>
          <td>#{@sudoku.get_TFOOD()}</td>
          <td>#{@sudoku.get_TET()}</td>
          <td>#{@sudoku.get_THA()}</td>
          <td>#{@sudoku.get_TLU()}</td>
          <td>#{@sudoku.get_EMR_WS()}</td>
          <td></td>
        </tr>
        <tr>
          <td>HH</td>
          <td>#{@sudoku.diet.get_HH_food()}</td>
          <td>#{@sudoku.households.get_ET_HH()}</td>
          <td>#{@sudoku.demographics.get_HA_HH()}</td>
          <td>negl.</td>
          <td>#{@sudoku.get_EMR_HH()}</td>
          <td></td>
        </tr>
        <tr>
          <td>SG</td>
          <td>#{@sudoku.diet.get_SG_food()}</td>
          <td>#{@sudoku.services.get_ET_SG()}</td>
          <td>#{@sudoku.services.get_HA_SG()}</td>
          <td>negl.</td>
          <td>#{@sudoku.get_EMR_SG()}</td>
          <td></td>
        </tr>
        <tr>
          <td>BM</td>
          <td>#{@sudoku.diet.get_BM_food()}</td>
          <td>#{@sudoku.bm.get_ET_BM()}</td>
          <td>#{@sudoku.bm.get_HA_BM()}</td>
          <td>negl.</td>
          <td>#{@sudoku.get_EMR_BM()}</td>
          <td></td>
        </tr>
        <tr>
          <td>AG</td>
          <td>#{@sudoku.diet.get_AG_food()}</td>
          <td>#{@sudoku.agriculture.get_ET_AG()}</td>
          <td>#{@sudoku.agriculture.get_HA_AG()}</td>
          <td>#{@sudoku.agriculture.get_LU_AG()}</td>
          <td>#{@sudoku.get_EMR_AG()}</td>
          <td></td>
        </tr>
        <tr>
          <td>EM</td>
          <td>N/A</td>
          <td>#{@sudoku.energy.get_ET_EM()}</td>
          <td>#{@sudoku.energy.get_HA_EM()}</td>
          <td>#{@sudoku.get_LU_EM()}</td>
          <td>#{@sudoku.get_EMR_EM()}</td>
          <td></td>
        </tr>
        <tr>
          <td colspan="8"></td>
        </tr>
        <tr>
          <td rowspan="3">Supply</td>
          <td>Domestic Supply</td>
          <td>#{@sudoku.get_DS_food()}</td>
          <td>#{@sudoku.get_DS_energy()}</td>
          <td>8760</td>
          <td>#{@sudoku.land.get_s_lan()}</td>
          <td colspan="2" rowspan="3"></td>
        </tr>
        <tr>
          <td>Imports</td>
          <td>#{@sudoku.get_imports_food()}</td>
          <td>#{@sudoku.get_imports_energy()}</td>
          <td>N/A</td>
          <td>N/A</td>
        </tr>
        <tr>
          <td>Virtuel Imports</td>
          <td>N/A</td>
          <td>N/A</td>
          <td>#{@sudoku.get_vimports_HA()}</td>
          <td>#{@sudoku.get_vimports_LU()}</td>
        </tr>
      </table>
      <hr>
      <p>
        Data used: <pre>#{localStorage.experiment}</pre>
      </p>
      """
    @$el.html(html)
    # precision -> 2
    @$el.find('td').each (i, td) ->
      val = $(td).text()
      if (val != "" && !isNaN(val))
        $(td).text(+(+val).toPrecision(2))
    @events()
    return this

  events: ->
