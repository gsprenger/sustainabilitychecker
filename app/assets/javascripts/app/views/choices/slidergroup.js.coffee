class window.SliderGroupView
  constructor:(@section, @slidergroup) ->
    @$el = $("<div class='slidergroup'>")
    if @slidergroup.slug == "ele" || @slidergroup.slug == "fue"
      @sliderImageView = new SliderImageView(@section, @slidergroup.slug)

  render: ->
    c = App.get().content
    p = @section.i18nPrefix
    @sliderViews = [] 
    for s in @slidergroup.sliders
      @sliderViews.push(new SliderView(@section, s, true))
    html = """      
        <div class='slidergroup-title'>
          #{c.text(p+'_slidergroup_'+@slidergroup.slug, 'none')}
        </div>
        """
    if @slidergroup.slug == "ele" || @slidergroup.slug == "fue"
      html += """
          <div class='row-fluid row-equalheight'>
            <div class='col-md-7 col-equalheight'>
              <div class='slidergroup-container'></div>
            </div>
            <div class='col-md-5 col-equalheight'>
              <div id='#{p}_sg_img_cont' class='sliders-image-cont'></div>
            </div>
          </div>
          <div class='clearfix'></div>
        """
    else
      html += """
          <div class='slidergroup-container'></div>
        """
    @$el.html(html)
    for v in @sliderViews
      @$el.find('.slidergroup-container').append(v.render().$el)
    if @slidergroup.slug == "ele" || @slidergroup.slug == "fue"
      @$el.find('.sliders-image-cont').append(@sliderImageView.render().$el)
    @events()
    return this

  events: ->
    # TODO: This part needs refactoring!!!
    $.each @sliderViews, (i, v) =>
      name = v.slider.slug
      sliderEl = v.$el.find('.slider')
      prevVal = 0
      slidingSlider = false
      sliderEl.on 'slidestart', (e, ui) =>
        prevVal = ui.value
      sliderEl.on 'slidechange', (e, ui) =>
        if slidingSlider
          $(window).trigger 'choicecomplete'
          slidingSlider = false
      sliderEl.on 'slide', (e, ui) =>
        slidingSlider = true
        # Get nearest value
        diff = null
        for val in v.slider.values
          newDiff = Math.abs(ui.value - val)
          if (diff == null || newDiff < diff)
            diff = newDiff
            nearest = val
        if (nearest != prevVal)
          prevVal = nearest
          sliderEl.slider('value', nearest)
          # Check constraints 
          total = 0
          for v2 in @sliderViews
            sEl = v2.$el.find('.slider')
            # get total value
            if v2.slider.slug == name
              total += nearest
            else 
              total += sEl.slider('value')
          # get difference to compensate on other sliders
          overflow = total > 100
          diff = Math.abs(100 - total)
          for v2 in @sliderViews by -1
            sEl2 = v2.$el.find('.slider')
            if (v2.slider.slug != name)
              # for each slider except current, starting from last
              sValue = sEl2.slider('value')
              sValues = v2.slider.values
              valToReach = sValue + (if overflow then -diff else diff)
              # if diff can be contained in last slider and is possible
              if (sValues.indexOf(valToReach) > -1)
                sEl2.slider('value', valToReach)
                diff -= diff
              else
                # we break diff into segments of 25 and try to shove it (dirty hack...)
                if (diff % 25 == 0)
                  times = diff / 25
                  for i in [1..times]
                    for v3 in @sliderViews by -1
                      sEl3 = v3.$el.find('.slider')
                      if (v3.slider.slug != name)
                        # for each slider except current, starting from last
                        tsValue = sEl3.slider('value')
                        tsValues = v3.slider.values
                        tvalToReach = tsValue + (if overflow then -25 else 25)
                        # if diff can be contained in last slider and is possible
                        if (tsValues.indexOf(tvalToReach) > -1)
                          sEl3.slider('value', tvalToReach)
                          diff -= 25
                          break
            if (diff == 0)
              break
          if (name == 'd_hou_urb' || name == 'd_hou_rur')
            hh = App.get().households
            hh.updateSecondGroup(if name == 'd_hou_urb' then nearest else 100 - nearest)
          if (@section.slug == "d_hou" || @section.slug == "s_ene")
            $(window).trigger 'updatesliderimage',
              section:     @section.slug, 
              slidergroup: @slidergroup.slug, 
              slider:      name
              value:       nearest
          if (diff != 0)
            console.error("This setup of linked sliders is probably not supported. Something must have gone wrong somewhere and the total is not 100 anymore.")
        return false
