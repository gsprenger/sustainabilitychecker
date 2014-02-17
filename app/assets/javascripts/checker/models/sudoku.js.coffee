class window.Sudoku
  # Data from team datasheet in CoffeeScript Object format
  @data = {}
 
  ###
  GETTERS
  ###

  ###
  FUNCTIONAL CODE
  ###
  @debug: ->
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
        </tr>
        <tr>
          <td><strong>Food</strong></td>
          <td><strong>Energy</strong></td>
          <td><strong>HA</strong></td>
          <td><strong>LU</strong></td>
        </tr>
        <tr>
          <td rowspan="6">Consumption</td>
          <td>WS</td>
          <td>TFOOD</td>
          <td>#{Energy.get_TET()}</td>
          <td>THA</td>
          <td>TLU</td>
        </tr>
        <tr>
          <td>HH</td>
          <td>#{Diet.get_grains_equiv()}</td>
          <td>#{Households.get_ET_HH()}</td>
          <td>HA_HH</td>
          <td>negl.</td>
        </tr>
        <tr>
          <td>SG</td>
          <td>N/A</td>
          <td>#{Services.get_ET_SG()}</td>
          <td>#{Services.get_HA_SG()}</td>
          <td>negl.</td>
        </tr>
        <tr>
          <td>BM</td>
          <td>Post-harvest losses</td>
          <td>#{Bm.get_ET_BM()}</td>
          <td>#{Bm.get_HA_BM()}</td>
          <td>negl.</td>
        </tr>
        <tr>
          <td>AG</td>
          <td>Food hyper</td>
          <td>#{Agriculture.get_ET_AG()}</td>
          <td>#{Agriculture.get_HA_AG()}</td>
          <td>#{Agriculture.get_LU_AG()}</td>
        </tr>
        <tr>
          <td>EM</td>
          <td>N/A</td>
          <td>#{Energy.get_ET_EM()}</td>
          <td>#{Energy.get_HA_EM()}</td>
          <td>#{Energy.get_LU_EM()}</td>
        </tr>
        <tr>
          <td rowspan="3">Supply</td>
          <td>Domestic Supply</td>
          <td>(TFOOD / #{Agriculture.get_LU_AG()}) * #{Land.get_s_lan()}</td>
          <td>#{Energy.get_TET() * (Land.get_s_lan() - Agriculture.get_LU_AG())}</td>
          <td>8760</td>
          <td>#{Land.get_s_lan()}</td>
        </tr>
        <tr>
          <td>Imports</td>
          <td>TFOOD - Domestic supply</td>
          <td>#{Energy.get_TET() - (Energy.get_TET() * (Land.get_s_lan() - Agriculture.get_LU_AG()))}</td>
          <td>N/A</td>
          <td>N/A</td>
        </tr>
        <tr>
          <td>Virtuel Imports</td>
          <td>N/A</td>
          <td>N/A</td>
          <td>THA - 8760</td>
          <td>TLU - #{Land.get_s_lan()}</td>
        </tr>
      </table>
      """
    $('#debug').html(html)
    $('#debug td').each (i, td) ->
      val = $(td).text()
      if (!isNaN(val) && val != "")
        $(td).text(
          Math.div(
            Math.round(Math.mul(val, 100)), 
            100))
    $('#debug').show()
    Navigation.smoothScrollTo('#debug')
