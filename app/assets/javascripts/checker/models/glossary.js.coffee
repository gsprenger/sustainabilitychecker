class window.Glossary
  @glossary = {}

  @setup: ->
    # extends jquery for case insensitive search
    jQuery.expr[":"].Contains = jQuery.expr.createPseudo (arg) ->
      return (elem) ->
        return jQuery(elem).text().toUpperCase().indexOf(arg.toUpperCase()) >= 0

    all = JSON.parse $.ajax({
      type:     'GET',
      dataType: 'json',
      url:      '/glossary/all',
      async:    false
    }).responseText
    for g in all
      Glossary.glossary[g.name] = g.definition
    return Glossary

  @parsePage: ->
    # TODO
