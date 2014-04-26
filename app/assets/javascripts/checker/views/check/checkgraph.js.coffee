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
      local_f = sudoku.get_DS_food()
      local_e = sudoku.get_DS_energy()
      imprt_f = sudoku.get_imports_food()
      imprt_e = sudoku.get_imports_energy()
      heightUpperFood = Math.round(local_f / (local_f + imprt_f) * 100)
      heightUpperEnergy = Math.round(local_e / (local_e + imprt_e) * 100)
      heightLowerFood = 100 - heightUpperFood
      heightLowerEnergy = 100 - heightUpperEnergy
      # update title
      if (heightUpperFood == 100 && heightUpperEnergy == 100)
        $('.check-result-title').addClass('passed')
        $('.check-result-title').text('Passed!')
      # update percents
      $('.bar-upper.bar-food .bar-percent').text(if heightUpperFood <= 10 then '' else heightUpperFood+'%')
      $('.bar-upper.bar-energy .bar-percent').text(if heightUpperEnergy <= 10 then '' else heightUpperEnergy+'%')
      #$('.bar-lower.bar-food .bar-percent').text(if heightLowerFood <= 10 then '' else heightLowerFood+'%')
      #$('.bar-lower.bar-energy .bar-percent').text(if heightLowerEnergy <= 10 then '' else heightLowerEnergy+'%')
      # Update bars: first top bars, then lower bars in red, then switch to original color.
      setTimeout ->
        $('.bar-upper.bar-food').css('height', heightUpperFood+'%')
        $('.bar-upper.bar-energy').css('height', heightUpperEnergy+'%')
        setTimeout ->
          $('.bar-lower.bar-food').css('height', heightLowerFood+'%')
          $('.bar-lower.bar-energy').css('height', heightLowerEnergy+'%')
        ,1000
      ,1000
