class window.Admin
  @BTNADD = '#btnadd'
  @BTNEDIT = '.btnedit'
  @BTNREMOVE = '.btnremove'
  @BTNADDMORE = '#more'
  @BTNADDLESS = '#less'
  @ADDSECTION = '.addgloss'
  @EDITSECTION = '.editgloss'
  @ADDNAMEINPUT = '.addgloss-name'
  @ADDSLUGINPUT = '.addgloss-slug'
  @ADDDEFTAREA = '.addgloss-def'
  @EDITNAMEINPUT = '.editgloss-name'
  @EDITPNAMEINPUT = '.editgloss-pname'
  @EDITSLUGINPUT = '.editgloss-slug'
  @EDITDEFTAREA = '.editgloss-def'

  @setup: ->
    @setupAddGlossary()
    @setupEditRemoveGlossary()

  @setupAddGlossary: ->
    count = 1
    # set events handlers
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
        slug = $(el).find(Admin.ADDSLUGINPUT).val()
        name = $(el).find(Admin.ADDNAMEINPUT).val()
        def = $(el).find(Admin.ADDDEFTAREA).val()
        glossary[i] = {name: name, slug: slug, def: def}
      $.ajax '/glossary/new',
        type: 'POST'
        dataType: 'json'
        data: {glossary: glossary}
        success: (returnVal) ->
          if (returnVal.success)
            $('.addsuccessalert').first().clone().removeClass('hidden').insertBefore(Admin.BTNADD)
          else
            $('.addfailurealert').first().clone().removeClass('hidden').append(returnVal.message).insertBefore(Admin.BTNADD)
        error: ->
          $('#addfailurealert').first().clone().removeClass('hidden').append(returnVal.message).insertBefore(Admin.BTNADD)

  @setupEditRemoveGlossary: ->
    $(Admin.BTNEDIT).on 'click', ->
      section = $(this).parents(Admin.EDITSECTION)
      slug = section.find(Admin.EDITSLUGINPUT).val()
      name = section.find(Admin.EDITNAMEINPUT).val()
      pname = section.find(Admin.EDITPNAMEINPUT).val()
      def = section.find(Admin.EDITDEFTAREA).val()
      $.ajax '/glossary/edit',
        type: 'POST'
        dataType: 'json'
        data: {name: name, pname: pname, slug: slug, def: def}
        success: (returnVal) ->
          if (returnVal.success)
            $('.editsuccessalert').first().clone().removeClass('hidden').prependTo(section)
            section.find(Admin.EDITPNAMEINPUT).val(name)
          else
            $('.editfailurealert').first().clone().removeClass('hidden').prependTo(section).append(returnVal.message)
        error: ->
          $('.editfailurealert').first().clone().removeClass('hidden').prependTo(section).append(returnVal.message)
    $(Admin.BTNREMOVE).on 'click', ->
      section = $(this).parents(Admin.EDITSECTION)
      pname = section.find(Admin.EDITPNAMEINPUT).val()
      $.ajax '/glossary/remove',
        type: 'POST'
        dataType: 'json'
        data: {name: pname}
        success: (returnVal) ->
          if (returnVal.success)
            $('.removesuccessalert').first().clone().prependTo(section).removeClass('hidden')
            section.remove()
          else
          $('.removefailurealert').first().clone().prependTo(section).removeClass('hidden').append(returnVal.message)
        error: ->
          $('.removefailurealert').first().clone().prependTo(section).removeClass('hidden').append(returnVal.message)


  @getAddGlossaryForm: (id, prefix) ->
    return """
      <div class='well well-sm #{prefix}gloss' id='#{prefix}gloss-#{id}'>
        <div class='form-group'>
          <label for='#{prefix}gloss-name-#{id}'>Name</label>
          <input type='text' class='form-control #{prefix}gloss-name' id='#{prefix}gloss-name-#{id}' placeholder='Name'>
        </div>
        <div class='form-group'>
          <label for='#{prefix}gloss-slug-#{id}'>Slug (short name)</label>
          <input type='text' class='form-control #{prefix}gloss-slug' id='#{prefix}gloss-slug-#{id}' placeholder='slug'>
        </div>
        <div class='form-group'>
          <label for='#{prefix}gloss-def-#{id}'>Definition</label>
          <textarea class='form-control #{prefix}gloss-def' id='#{prefix}gloss-def-#{id}' rows=3></textarea>
        </div>
      </div>
      """
