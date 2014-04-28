class window.Admin
  @BTNADD = '#btnadd'
  @BTNEDIT = '.btnedit'
  @BTNREMOVE = '.btnremove'
  @BTNADDMORE = '#more'
  @BTNADDLESS = '#less'
  @ADDSECTION = '.addgloss'

  @setup: ->
    @setupAddGlossary()
    @setupEditRemoveGlossary()

  @setupAddGlossary: ->
    count = 0
    $(Admin.getAddGlossaryForm(count++, 'add')).insertBefore(Admin.BTNADD)
    $(Admin.BTNADDMORE).on 'click', ->
      $(Admin.getAddGlossaryForm(count++, 'add')).insertBefore(Admin.BTNADD)
      if count > 1
        $(Admin.BTNADDLESS).removeClass('disabled')
    $(Admin.BTNADDLESS).on 'click', ->
      $(Admin.ADDSECTION).last().remove();
      count--
      if count <= 1
        $(Admin.BTNADDLESS).addClass('disabled')
    $(Admin.BTNADD).on 'click', ->
      glossary = {}
      $(Admin.ADDSECTION).each (i, el) ->
        input = $(el).find('input').val()
        tarea = $(el).find('textarea').val()
        glossary[input] = tarea
      $.ajax '/glossary/save',
        type: 'POST'
        dataType: 'json'
        data: {glossary: glossary}
        success: ->
          $('#addsuccessalert').clone().removeClass('hidden').insertBefore('#addsuccessalert').slideDown('slow');
        error: ->
          $('#addfailurealert').clone().removeClass('hidden').insertBefore('#addsuccessalert').slideDown('slow');

  @setupEditRemoveGlossary: ->
    $(Admin.BTNEDIT).on 'click', ->
      section = $(this).parents('.editgloss')
      input = section.find('input').val()
      tarea = section.find('textarea').val()
      $.ajax '/glossary/edit',
        type: 'POST'
        dataType: 'json'
        data: {name: input, definition: tarea}
        success: ->
          $('#editsuccessalert').clone().removeClass('hidden').prependTo(section).slideDown('slow');
        error: ->
          $('#editfailurealert').clone().removeClass('hidden').prependTo(section).slideDown('slow');
    $(Admin.BTNREMOVE).on 'click', ->
      section = $(this).parents('.editgloss')
      input = section.find('input').val()
      $.ajax '/glossary/remove',
        type: 'POST'
        dataType: 'json'
        data: {name: input}
        success: ->
          $('#removesuccessalert').clone().insertBefore(section).removeClass('hidden').slideDown('slow');
          section.remove()
        error: ->
          $('#removefailurealert').clone().prependTo(section).removeClass('hidden').slideDown('slow');


  @getAddGlossaryForm: (id, prefix) ->
    return """
      <div class='well well-sm #{prefix}gloss' id='#{prefix}gloss-#{id}'>
        <div class='form-group'>
          <label for='#{prefix}gloss-name-#{id}'>Name</label>
          <input type='text' class='form-control' id='#{prefix}gloss-name-#{id}' placeholder='Name'>
        </div>
        <div class='form-group'>
          <label for='#{prefix}gloss-def-#{id}'>Definition</label>
          <textarea class='form-control' id='#{prefix}gloss-def-#{id}' rows=3></textarea>
        </div>
      </div>
      """
