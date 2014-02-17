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
      <table>
        <tr>
          <td></td>
          <td></td>
          <td>Flows</td>
          <td></td>
          <td>Funds</td>
          <td></td>
        </tr>
        <tr>
          <td></td>
          <td></td>
          <td>Food</td>
          <td>Energy</td>
          <td>HA</td>
          <td>LU</td>
        </tr>
        <tr>
          <td>Consumption</td>
          <td>WS</td>
          <td>TFOOD</td>
          <td>#{Energy.get_TET()}</td>
          <td>THA</td>
          <td>TLU</td>
        </tr>
        <tr>
          <td></td>
          <td>HH</td>
          <td>#{Diet.get_grains_equiv()}</td>
          <td>#{Households.get_ET_HH()}</td>
          <td>HA_HH</td>
          <td>negl.</td>
        </tr>
        <tr>
          <td></td>
          <td>SG</td>
          <td>N/A</td>
          <td>#{Services.get_ET_SG()}</td>
          <td>#{Services.get_HA_SG()}</td>
          <td>negl.</td>
        </tr>
        <tr>
          <td></td>
          <td>BM</td>
          <td>Post-harvest losses</td>
          <td>#{Bm.get_ET_BM()}</td>
          <td>#{Bm.get_HA_BM()}</td>
          <td>negl.</td>
        </tr>
        <tr>
          <td></td>
          <td>AG</td>
          <td>Food hyper</td>
          <td>#{Agriculture.get_ET_AG}</td>
          <td>#{Agriculture.get_HA_AG}</td>
          <td>#{Agriculture.get_LU_AG}</td>
        </tr>
        <tr>
          <td></td>
          <td>EM</td>
          <td>N/A</td>
          <td>#{Energy.get_ET_EM()}</td>
          <td>#{Energy.get_HA_EM()}</td>
          <td>#{Energy.get_LU_EM()}</td>
        </tr>
        <tr></tr>
        <tr>
          <td>Supply</td>
          <td>Domestic Supply</td>
          <td>(TFOOD / #{Agriculture.get_LU_AG}) * #{Land.get_s_lan()}</td>
          <td>(#{Energy.get_TET() * (Land.get_s_lan() - Agriculture.get_LU_AG)}</td>
          <td>8760</td>
          <td>#{Land.get_s_lan()}}/td>
        </tr>
        <tr>
          <td></td>
          <td>Imports</td>
          <td>TFOOD - Domestic supply</td>
          <td>#{Energy.get_TET() - (Energy.get_TET() * (Land.get_s_lan() - Agriculture.get_LU_AG))}</td>
          <td>N/A</td>
          <td>N/A</td>
        </tr>
        <tr>
          <td></td>
          <td>Virtuel Imports</td>
          <td>N/A</td>
          <td>N/A</td>
          <td>THA - 8760</td>
          <td>TLU - #{Land.get_s_lan()}</td>
        </tr>
      </table>
      """
    $('#debug').html(html)
