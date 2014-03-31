class window.SectionModel
  constructor: (@name, @slug, @type) ->

  contentModified: ->
    $(window).trigger('sectionComplete', [@name, @slug])

