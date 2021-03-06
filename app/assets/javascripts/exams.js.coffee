$ ->
  # open and close courses filter
  $('#courses-list > ul > li > span').click ->
    $(@).parent().toggleClass('open')
    $(@).parent().children('ul').stop().slideToggle()
  $('#courses-list input').each ->
    if $(@).attr('checked')
      $(@).closest('ul').parent('li').addClass('open')
      $(@).closest('ul').show()
  # render changes of number of questions filter
  $('#number_of_questions').change ->
    $(@).prev().text('maximaal ' + $(@).val() + ' vragen')
  $('#number_of_questions').prev().text('maximaal ' + $('#number_of_questions').val() + ' vragen')
  # render changes of average difficulty filter
  $('#average_difficulty').change ->
    $(@).prev().text('tot en met ' + $(@).val())
  $('#average_difficulty').prev().text('tot en met ' + $('#average_difficulty').val())
  # render changes of amount of time filter
  $('#amount_of_time').change ->
    $(@).prev().text('maximaal ' + $(@).val() + ' minuten')
  $('#amount_of_time').prev().text('maximaal ' + $('#amount_of_time').val() + ' minuten')
  # initialize exams on page load
  if $('body').attr('id') is 'exams' and $('body').attr('data-action') is 'index'
    filterExams()
    # bind filter events
    $('#search').keyup -> filterExams()
    $('#courses-list input, #number_of_questions, #average_difficulty, #amount_of_time').change -> filterExams()
  # quick n dirty exam validations
  $('#exams .actions input[type=submit]').click (e) ->
    course_valid = true
    title_valid = true
    description_valid = true
    questions_valid = true
    course_valid = false if $('.course input[type=radio]:checked').length is 0
    title_valid = false if $('#exam_title').val() is ''
    description_valid = false if $('textarea').first().val() is ''
    $('#exam-questions .xlarge').each ->
      if $(@).val() is ''
        questions_valid = false
    if not course_valid or not title_valid or not description_valid or not questions_valid
      e.preventDefault()
      $('.block-message li').first().show() if not course_valid
      $('.block-message li').first().next().show() if not title_valid
      $('.block-message li').first().next().next().show() if not description_valid
      $('.block-message li').last().show() if not questions_valid
      $('.block-message').slideDown()
      $('html, body').animate({ scrollTop: 0 }, 'slow')
      $('.block-message').delay(5000).slideUp ->
        $('.block-message li').hide()

# serialize filter form and retrieve exams accordingly
filterExams = () ->
  $('#exams-list').children(':not(.spinner)').remove()
  $('.span11 h2 small').empty()
  $('#exams-list .spinner').show()
  # cancel any in progress ajax request
  window.stop()
  # get exams with filters applied
  $.getJSON('/exams?' + $('#filters form').serialize(), (data) -> buildExamsList(data))

# quick n dirty templating of exams list
buildExamsList = (data) ->
  template = ''
  if data.length is 0
    template += '<p>Geen tentamens gevonden.</p>'
  else
    months = ['januari', 'februari', 'maart', 'april', 'mei', 'juni', 'juli', 'augustus', 'september', 'oktober', 'november', 'december']
    for item in data
      date = item.created_at.substr(0, 10).split('-')
      date = date[2] + ' ' + months[(date[1] - 1)] + ' ' + date[0]
      template += '<div class="exam-item">
                    <h3 class="pull-left"><a href="/exams/' + item._id + '/edit">' + item.title + '</a> <small>' + item.category_name + ' - ' + item.course_name + '</small></h3>
                    <a href="/exams/' + item._id + '.pdf?answers=1" title="PDF-nakijkversie met antwoorden" class="pull-right"><img width="32" height="32" src="/assets/Antwoorden.png" /></a>
                    <a class="pull-right" href="/exams/' + item._id + '.pdf" title="PDF-versie" class="pull-right" style="margin-right: 10px;"><img width="32" height="32" src="/assets/PDFknoprood.png" /></a>
                    <table class="condensed-table">
                      <tr><td>Aantal vragen:</td><td>' + item.number_of_questions + ' vragen</td></tr>
                      <tr><td>Tijdsduur:</td><td>' + item.amount_of_time + ' minuten</td><td>Moeilijkheid:</td><td>' + item.average_difficulty + ' uit 10</td></tr>
                      <tr><td>Gemaakt op:</td><td>' + date + '</td><td>Gemaakt door:</td><td>' + item.author + '</td></tr>
                    </table>
                  </div>'
  $('.span11 h2 small').text(data.length + ' gevonden') if data.length > 0
  $('#exams-list .spinner').hide()
  $('#exams-list .spinner').after(template)