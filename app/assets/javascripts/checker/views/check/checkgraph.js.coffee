class window.CheckGraphView
  constructor: ->
    @$el = $("<div id='checkgraph'>")

  render: ->
    c = App.get().content
    html = """
      <div class='row'>
        <div class='cell col-xs-3'>
          <div class='graph-title upper'>#{c.text('chkr_res_local')}</div>
        </div>
        <div class='cell col-xs-2'>
          <div class='bar-upper bar-food'>
            <div class='bar-percent'>0%</div>
          </div>
        </div>
        <div class='col-xs-2 visible-xs'></div>
        <div class='cell col-xs-2 col-sm-offset-2'>
          <div class=' bar-upper bar-energy'>
            <div class='bar-percent'>0%</div>
          </div>
        </div>
      </div>
      <hr class='graph-axis'>
      <div class='row'>
        <div class='cell col-xs-3'>
          <div class='graph-title lower'>#{c.text('chkr_res_imported')}</div>
        </div>
        <div class='cell col-xs-2'>
          <div class='bar-lower bar-food'>
            <div class='bar-percent'>0%</div>
            <div class='bar-title'>#{c.text('chkr_res_food')}</div>
          </div>
        </div>
        <div class='col-xs-2 visible-xs'></div>
        <div class='cell col-xs-2 col-sm-offset-2'>
          <div class='bar-lower bar-energy'>
            <div class='bar-percent'>0%</div>
            <div class='bar-title'>#{c.text('chkr_res_energy')}</div>
          </div>
        </div>
      </div>
      """
    @$el.html(html)
    @events()
    return this

  events: ->    
    $(window).on 'clickshowresult', =>
      # Perform calculations
      sudoku = App.get().sudoku
      heightUpperFood = sudoku.get_percent_local_food()
      heightUpperEnergy = sudoku.get_percent_local_energy()
      heightLowerFood = 100 - heightUpperFood
      heightLowerEnergy = 100 - heightUpperEnergy
      # update percents
      $('.bar-upper.bar-food .bar-percent').text(if heightUpperFood <= 15 then '' else heightUpperFood+'%')
      $('.bar-upper.bar-energy .bar-percent').text(if heightUpperEnergy <= 15 then '' else heightUpperEnergy+'%')
      $('.bar-lower.bar-food .bar-percent').text(if heightLowerFood <= 15 then '' else heightLowerFood+'%')
      $('.bar-lower.bar-energy .bar-percent').text(if heightLowerEnergy <= 15 then '' else heightLowerEnergy+'%')
      # update color
      $('.bar-food').addClass('bar-'+(if heightUpperFood >= 80 then 80 else 0))
      $('.bar-energy').addClass('bar-'+(if heightUpperEnergy >= 80 then 80 else 0))
      # Update bars: first top bars, then lower bars.
      # setTimeout ->
      $('.bar-upper.bar-food').css('height', heightUpperFood+'%')
      $('.bar-upper.bar-energy').css('height', heightUpperEnergy+'%')
        # setTimeout ->
      $('.bar-lower.bar-food').css('height', heightLowerFood+'%')
      $('.bar-lower.bar-energy').css('height', heightLowerEnergy+'%')
        # ,1000
      # ,1000
