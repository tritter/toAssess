$ ->
  # hide flash messages
  $('div.success, div.warning, div.error').delay(3000).fadeOut('fast')
  if ($('body').attr('id') is 'exams' or $('body').attr('id') is 'questions') and ($('body').attr('data-action') is 'new' or $('body').attr('data-action') is 'edit')
    setInterval(colorizeCode, 2000) # continuously look for code tags to render
    setInterval(togglePreview, 5) # show or hide preview tags if filled or empty
    runEditors() # initialize markdown editors

# render markdown editors
window.runEditors = ->
  help = ->
    window.open('http://daringfireball.net/projects/markdown/syntax', '_blank')
  converters = []
  editors = []
  $('.wmd-button-row').remove();
  $('textarea').each ->
    number = parseInt($(@).attr('id').match(/\d+/)[0])
    converters.push(new Markdown.Converter())
    editors.push(new Markdown.Editor(converters[(converters.length - 1)], '-' + number, { handler: help }))
    editors[(editors.length - 1)].run()

# render code in nice colors
colorizeCode = ->
  $('code').addClass('prettyprint')
  prettyPrint()
togglePreview = ->
  $('textarea').each ->
    if $(@).val() is ''
      $(@).next().hide()
    else
      $(@).next().show()