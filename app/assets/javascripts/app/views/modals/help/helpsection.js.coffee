class window.HelpSectionView
  constructor:(@prefix) ->
    @$el = $('<div class="helpsection-cont">')

  render: ->
    c = App.get().content
    html = """
      <div class='row'>
        <div class='col-xs-8'>
          <div class='tab-content'>
            <!-- Levels -->
            <div class='tab-pane fade in active' id='#{@prefix}tablevel1'>
              #{c.text('modal_help_level1', 'none')}
            </div>
            <div class='tab-pane fade' id='#{@prefix}tablevel2'>
              #{c.text('modal_help_level2', 'none')}
            </div>
            <div class='tab-pane fade' id='#{@prefix}tablevel3'>
              #{c.text('modal_help_level3', 'none')}
            </div>
            <!-- Demand -->
            <div class='tab-pane fade' id='#{@prefix}tabdem'>
              #{c.text('modal_help_dem', 'none')}
            </div>
            <div class='tab-pane fade' id='#{@prefix}tabdie'>
              #{c.text('modal_help_die', 'none')}
            </div>
            <div class='tab-pane fade' id='#{@prefix}tabhou'>
              #{c.text('modal_help_hou', 'none')}
            </div>
            <div class='tab-pane fade' id='#{@prefix}tabser'>
              #{c.text('modal_help_ser', 'none')}
            </div>
            <!-- Supply -->
            <div class='tab-pane fade' id='#{@prefix}tablan'>
              #{c.text('modal_help_lan', 'none')}
            </div>
            <div class='tab-pane fade' id='#{@prefix}tabbm'>
              #{c.text('modal_help_bm', 'none')}
            </div>
            <div class='tab-pane fade' id='#{@prefix}tabagr'>
              #{c.text('modal_help_agr', 'none')}
            </div>
            <div class='tab-pane fade' id='#{@prefix}tabene'>
              #{c.text('modal_help_ene', 'none')}
            </div>
            <div class='tab-pane fade' id='#{@prefix}tabcheck'>
              #{c.text('modal_help_check', 'none')}
            </div>
          </div>
        </div>
        <div class='col-xs-4 icon-cont'>
          <div class='row'>
            <div class='col-xs-4 helptabicon-cont'>
              <a href="##{@prefix}tablevel1" role="tab" data-toggle="tab" class='tabtrigger tablevel'>
                <div class='helptabicon active'>
                  <div class='help-table'>
                    <div class='help-cell'>
                      Level 1
                    </div>
                  </div>
                </div>
              </a>
            </div>
            <div class='col-xs-4 helptabicon-cont'>
              <a href="##{@prefix}tablevel2" role="tab" data-toggle="tab" class='tabtrigger tablevel'>
                <div class='helptabicon'>
                  <div class='help-table'>
                    <div class='help-cell'>
                      Level 2
                    </div>
                  </div>
                </div>
              </a>
            </div>
            <div class='col-xs-4 helptabicon-cont'>
              <a href="##{@prefix}tablevel3" role="tab" data-toggle="tab" class='tabtrigger tablevel'>
                <div class='helptabicon'>
                  <div class='help-table'>
                    <div class='help-cell'>
                      Level 3
                    </div>
                  </div>
                </div>
              </a>
            </div>
          </div>
          <hr>
          <div class='row'>
            <div class='col-xs-3 helptabicon-cont'>
              <a href="##{@prefix}tabdem" role="tab" data-toggle="tab" class='tabtrigger tabdem'>
                <div class='helptabicon'>
                  <div class='help-table'>
                    <div class='help-cell'>
                      <i class='fa fa-users'></i>
                    </div>
                  </div>
                </div>
              </a>
            </div>
            <div class='col-xs-3 helptabicon-cont'>
              <a href="##{@prefix}tabdie" role="tab" data-toggle="tab" class='tabtrigger tabdem'>
                <div class='helptabicon'>
                  <div class='help-table'>
                    <div class='help-cell'>
                      <i class='fa fa-cutlery'></i>
                    </div>
                  </div>
                </div>
              </a>
            </div>
            <div class='col-xs-3 helptabicon-cont'>
              <a href="##{@prefix}tabhou" role="tab" data-toggle="tab" class='tabtrigger tabdem'>
                <div class='helptabicon'>
                  <div class='help-table'>
                    <div class='help-cell'>
                      <i class='fa fa-home'></i>
                    </div>
                  </div>
                </div>
              </a>
            </div>
            <div class='col-xs-3 helptabicon-cont'>
              <a href="##{@prefix}tabser" role="tab" data-toggle="tab" class='tabtrigger tabdem'>
                <div class='helptabicon'>
                  <div class='help-table'>
                    <div class='help-cell'>
                      <i class='fa fa-medkit'></i>
                    </div>
                  </div>
                </div>
              </a>
            </div>
          </div>
          <br>
          <div class='row'>
            <div class='col-xs-3 helptabicon-cont'>
              <a href="##{@prefix}tablan" role="tab" data-toggle="tab" class='tabtrigger tabsup'>
                <div class='helptabicon'>
                  <div class='help-table'>
                    <div class='help-cell'>
                      <i class='fa fa-picture-o'></i>
                    </div>
                  </div>
                </div>
              </a>
            </div>
            <div class='col-xs-3 helptabicon-cont'>
              <a href="##{@prefix}tabbm" role="tab" data-toggle="tab" class='tabtrigger tabsup'>
                <div class='helptabicon'>
                  <div class='help-table'>
                    <div class='help-cell'>
                      <i class='fa fa-wrench'></i>
                    </div>
                  </div>
                </div>
              </a>
            </div>
            <div class='col-xs-3 helptabicon-cont'>
              <a href="##{@prefix}tabagr" role="tab" data-toggle="tab" class='tabtrigger tabsup'>
                <div class='helptabicon'>
                  <div class='help-table'>
                    <div class='help-cell'>
                      <i class='fa fa-leaf'></i>
                    </div>
                  </div>
                </div>
              </a>
            </div>
            <div class='col-xs-3 helptabicon-cont'>
              <a href="##{@prefix}tabene" role="tab" data-toggle="tab" class='tabtrigger tabsup'>
                <div class='helptabicon'>
                  <div class='help-table'>
                    <div class='help-cell'>
                      <i class='fa fa-fire'></i>
                    </div>
                  </div>
                </div>
              </a>
            </div>
          </div>
          <hr>
          <div class='row'>
            <div class='col-xs-12 helptabicon-cont'>
              <a href="##{@prefix}tabcheck" role="tab" data-toggle="tab" class="tabtrigger tabcheck">
                <div class='helptabicon'>
                  <div class='help-table'>
                    <div class='help-cell'>
                      <i class='fa fa-check'></i> Check
                    </div>
                  </div>
                </div>
              </a>
            </div>
          </div>
        </div>
      </div>
    """
    @$el.html(html)
    @events()
    return this

  events: ->
    @$el.find('.tabtrigger').on 'click', (e) =>
      @$el.find('.helptabicon').removeClass('active')
      $(e.currentTarget).find('.helptabicon').addClass('active')
