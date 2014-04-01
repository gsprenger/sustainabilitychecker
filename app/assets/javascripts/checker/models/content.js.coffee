class window.ContentModel
  @contents = {}

  @setup: ->
    all = JSON.parse $.ajax({
      type:     'GET',
      dataType: 'json',
      url:      '/content/all',
      async:    false
    }).responseText
    for c in all
      ContentModel.contents[c.slug] = c.content

  @text:(slug, type) ->
    content = ContentModel.contents[slug]
    switch type
      when 'simple'
        html = "<span data-mercury='simple' id='"+slug+"'>"+content+"</span>"
      when 'image'
        html = "<img data-mercury='image' id='"+slug+"' src='"+content+"'>"
      else
        html = "<div data-mercury='full' id='"+slug+"'>"+content+"</div>"
    return html
