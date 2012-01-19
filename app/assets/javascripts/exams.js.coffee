$ ->
  $('#filters #courses-list > ul > li > span').click ->
    $(@).parent().toggleClass('open')
    $(@).parent().children('ul').stop().slideToggle()
  $('#filters #courses-list input').each ->
    if $(@).attr('checked')
      $(@).closest('ul').parent('li').addClass('open')
      $(@).closest('ul').show()
  $('#number_of_questions').change ->
    $(@).prev().text('maximaal ' + $(@).val() + ' vragen')
  $('#number_of_questions').prev().text('maximaal ' + $('#number_of_questions').val() + ' vragen')
  $('#average_difficulty').change ->
    $(@).prev().text('tot en met ' + $(@).val())
  $('#average_difficulty').prev().text('tot en met ' + $('#average_difficulty').val())
  $('#amount_of_time').change ->
    $(@).prev().text('maximaal ' + $(@).val() + ' minuten')
  $('#amount_of_time').prev().text('maximaal ' + $('#amount_of_time').val() + ' minuten')
  #initialize exams
  if $('body').attr('id') is 'exams' and $('body').attr('data-action') is 'index'
    filterExams()
    #bind filter events
    $('#search').keyup -> filterExams()
    $('#courses-list input, #number_of_questions, #average_difficulty, #amount_of_time').change -> filterExams()
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
      $('.block-message').slideDown();
      $('html, body').animate({ scrollTop: 0 }, 'slow');
      $('.block-message').delay(5000).slideUp ->
        $('.block-message li').hide()

filterExams = () ->
  $('#exams-list').children(':not(.spinner)').remove()
  $('.span11 h2 small').empty()
  $('#exams-list .spinner').show()
  window.stop() # cancel any current ajax request
  $.getJSON('/exams?' + $('#filters form').serialize(), (data) -> buildExamList(data))

buildExamList = (data) ->
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
                    <table class="condensed-table">
                      <tr><td>Onderwerpen:</td><td colspan="3">*TODO*</td></tr>
                      <tr><td>Aantal vragen:</td><td>' + item.number_of_questions + ' vragen</td><td>Type vragen:</td><td>*TODO*</td></tr>
                      <tr><td>Tijdsduur:</td><td>' + item.amount_of_time + ' minuten</td><td>Moeilijkheid:</td><td>' + item.average_difficulty + ' uit 10</td></tr>
                      <tr><td>Gemaakt op:</td><td>' + date + '</td><td>Gemaakt door:</td><td>' + item.author + '</td></tr>
                    </table>
                  </div>'
  $('.span11 h2 small').text(data.length + ' gevonden') if data.length > 0
  $('#exams-list .spinner').hide()
  $('#exams-list .spinner').after(template)