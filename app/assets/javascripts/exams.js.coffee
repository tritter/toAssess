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

  $('#add-open-question, #add-mc-question, #add-thesis-question').click ->
    user_id = $('#exam-user-id').val()
    index = parseInt($('#questions').find('tbody').last().find('td').first().text()) || 0
    template = '<thead><tr><th>#</th><th>Type</th><th>Vraag</th><th>Antwoord</th><th>Verwijderen</th></tr></thead>'
    if $(@).attr('id') == 'add-open-question'
       template += '<tbody>
                      <tr>
                        <td>' + (index + 1) + '<input type="hidden" name="exam[questions_attributes][' + index + '][user_id]" value="' + user_id + '" /></td>
                        <td>Open<input type="hidden" name="exam[questions_attributes][' + index + '][question_type]" value="open" /></td>
                        <td><input type="text" name="exam[questions_attributes][' + index + '][question]" /></td>
                        <td><textarea name="exam[questions_attributes][' + index + '][answer]" rows="5"></textarea></td>
                        <td>
                          <input as="boolean" name="exam[questions_attributes][' + index + '][_destroy]" type="checkbox" value="1" />
                          <input type="hidden" name="exam[questions_attributes][' + index + '][difficulty]" value="8" />
                          <input type="hidden" name="exam[questions_attributes][' + index + '][time]" value="5" />
                        </td>
                      </tr>
                    </tbody>'
    if $(@).attr('id') == 'add-mc-question'
       template += '<tbody>
                      <tr>
                        <td>' + (index + 1) + '<input type="hidden" name="exam[questions_attributes][' + index + '][user_id]" value="' + user_id + '" /></td>
                        <td>Multiple-choice<input type="hidden" name="exam[questions_attributes][' + index + '][question_type]" value="mc" /></td>
                        <td><input type="text" name="exam[questions_attributes][' + index + '][question]" /></td>
                        <td>
                          <div class="clearfix">
                            <div class="input-prepend">
                              <label class="add-on">A <input type="radio" name="exam[questions_attributes][' + index + '][correct]" value="0"></label>
                              <input class="mini" name="exam[questions_attributes][' + index + '][answer][0][text]" size="30" type="text">
                            </div>
                          </div>
                          <div class="clearfix">
                            <div class="input-prepend">
                              <label class="add-on">B <input type="radio" name="exam[questions_attributes][' + index + '][correct]" value="1"></label>
                              <input class="mini" name="exam[questions_attributes][' + index + '][answer][1][text]" size="30" type="text">
                            </div>
                          </div>
                          <div class="clearfix">
                            <div class="input-prepend">
                              <label class="add-on">C <input type="radio" name="exam[questions_attributes][' + index + '][correct]" value="2"></label>
                              <input class="mini" name="exam[questions_attributes][' + index + '][answer][2][text]" size="30" type="text">
                            </div>
                          </div>
                          <div class="clearfix">
                            <div class="input-prepend">
                              <label class="add-on">D <input type="radio" name="exam[questions_attributes][' + index + '][correct]" value="3"></label>
                              <input class="mini" name="exam[questions_attributes][' + index + '][answer][3][text]" size="30" type="text">
                            </div>
                          </div>
                        </td>
                        <td>
                          <input as="boolean" name="exam[questions_attributes][' + index + '][_destroy]" type="checkbox" value="1" />
                          <input type="hidden" name="exam[questions_attributes][' + index + '][difficulty]" value="8" />
                          <input type="hidden" name="exam[questions_attributes][' + index + '][time]" value="5" />
                        </td>
                      </tr>
                    </tbody>'
    if $(@).attr('id') == 'add-thesis-question'
       template += '<tbody>
                      <tr>
                        <td>' + (index + 1) + '<input type="hidden" name="exam[questions_attributes][' + index + '][user_id]" value="' + user_id + '" /></td>
                        <td>Stelling<input type="hidden" name="exam[questions_attributes][' + index + '][question_type]" value="thesis" /></td>
                        <td>
                          <div class="clearfix">
                            <div class="input"><input type="text" name="exam[questions_attributes][' + index + '][question]" /></div>
                          </div>
                          <div class="clearfix">
                            <label>Stelling 1:</label>
                            <div class="input">
                              <input type="text" name="exam[questions_attributes][' + index + '][thesis][0][text]" />
                            </div>
                          </div>
                          <div class="clearfix">
                            <label>Stelling 2:</label>
                            <div class="input">
                              <input type="text" name="exam[questions_attributes][' + index + '][thesis][1][text]" />
                            </div>
                          </div>
                        </td>
                        <td>
                          <ul class="inputs-list">
                            <li>
                              <label>
                                <input type="radio" name="exam[questions_attributes][' + index + '][correct]" value="0">
                                <span>Stelling 1 is waar.</span>
                              </label>
                            </li>
                            <li>
                              <label>
                                <input type="radio" name="exam[questions_attributes][' + index + '][correct]" value="1">
                                <span>Stelling 2 is waar.</span>
                              </label>
                            </li>
                            <li>
                              <label>
                                <input type="radio" name="exam[questions_attributes][' + index + '][correct]" value="2">
                                <span>Beide stellingen zijn waar.</span>
                              </label>
                            </li>
                            <li>
                              <label>
                                <input type="radio" name="exam[questions_attributes][' + index + '][correct]" value="3">
                                <span>Beide stellingen zijn niet waar.</span>
                              </label>
                            </li>
                          </ul>
                        </td>
                        <td>
                          <input as="boolean" name="exam[questions_attributes][' + index + '][_destroy]" type="checkbox" value="1" />
                          <input type="hidden" name="exam[questions_attributes][' + index + '][difficulty]" value="8" />
                          <input type="hidden" name="exam[questions_attributes][' + index + '][time]" value="5" />
                        </td>
                      </tr>
                    </tbody>'
    $('#questions').append(template)
    false
  #initialize exams
  if $('body').attr('id') is 'exams' and $('body').attr('data-action') is 'index'
    filterExams()
    #bind filter events
    $('#search').keyup -> filterExams()
    $('#courses-list input, #number_of_questions, #average_difficulty, #amount_of_time').change -> filterExams()

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