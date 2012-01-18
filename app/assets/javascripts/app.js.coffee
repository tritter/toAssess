$ ->
  $('div.success, div.warning, div.error').delay(3000).fadeOut('fast')
  if ($('body').attr('id') is 'exams' or $('body').attr('id') is 'questions') and ($('body').attr('data-action') is 'new' or $('body').attr('data-action') is 'edit')
    setInterval(colorize, 200)
    setInterval(togglePreview, 5)
    help = ->
      alert('help')
    converters = []
    editors = []
    $('textarea').each (i) ->
      converters.push(new Markdown.Converter())
      editors.push(new Markdown.Editor(converters[(converters.length - 1)], '-' + i, { handler: help }))
      editors[(editors.length - 1)].run()

colorize = ->
  $('code').addClass('prettyprint')
  prettyPrint()
togglePreview = ->
  $('textarea').each ->
    if $(@).val() is ''
      $(@).next().hide()
    else
      $(@).next().show()