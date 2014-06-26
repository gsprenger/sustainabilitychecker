class window.Content
  @contents = {}

  @setup: ->
    param = 'mercury='+(if App.get().isMercury then 'true' else 'false')
    all = JSON.parse $.ajax({
      type:     'GET',
      dataType: 'json',
      url:      "/content/all?#{param}",
      async:    false
    }).responseText
    for c in all
      Content.contents[c.slug] = c.content
    return Content

  @text:(slug, type) ->
    content = Content.contents[slug] || slug
    switch type
      when 'simple'
        html = "<span data-mercury='simple' id='"+slug+"'>"+content+"</span>"
      when 'image'
        html = "<img data-mercury='image' id='"+slug+"' src='"+content+"'>"
      when 'none'
        html = content
      when 'attr'
        html = content.replace(/\'/, "&#39;").replace(/\"/, "&#34;")
      else
       html = "<div data-mercury='full' id='"+slug+"'>"+content+"</div>"
    return html
