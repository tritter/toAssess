$ ->
  # quick n dirty validations
  $('#new_question .actions input[type=submit], .edit_question .actions input[type=submit]').click (e) ->
    question_valid = true
    question_valid = false if $('.xlarge').val() is '' or ($('form').attr('id') is 'new_question' and $('.actions input[type=radio]:checked').length is 0)
    if not question_valid
      e.preventDefault()
      $('.block-message li').first().show()
      $('.block-message').slideDown()
      $('html, body').animate({ scrollTop: 0 }, 'slow');
      $('.block-message').delay(5000).slideUp ->
        $('.block-message li').hide()
  # initialize titles
  renderTitles()
  # quick n dirty question additions and templating in exam form
  $('#add-open-question, #add-true_false-question, #add-multiple_choice-question, #add-multiple_answers-question, #add-statements-question').click ->
    user_id = $('#exam-user-id').val()
    index = parseInt($('#exam-questions > div').last().find('h3 span').text()) || 0
    number = index + 1;
    meta = '<div class="clearfix">
              <div class="input">
                <input type="hidden" name="exam[questions_attributes][' + index + '][user_id]" value="' + user_id + '" />
                <input type="checkbox" name="exam[questions_attributes][' + index + '][_destroy]" value="1" /><span class="delete-question"> Vraag verwijderen</span>
              </div>
            </div>
            <div class="clearfix">
              <label>Moeilijkheid</label>
              <div class="input">
                <input type="text" class="span1" name="exam[questions_attributes][' + index + '][difficulty]" value="5" /><span> uit 10</span>
              </div>
            </div>
            <div class="clearfix">
              <label>Tijdsduur</label>
              <div class="input">
                <input type="text" class="span1" name="exam[questions_attributes][' + index + '][time]" value="5" /><span> minuten</span>
              </div>
            </div>'
    template = ''
    if $(@).attr('id') == 'add-open-question'
       template += '<div class="open-question">
                      <h3><span>' + number + '. </span><span class="question-title"></span><small>Open vraag</small></h3>
                      <div class="clearfix">
                        <label>Vraag</label>
                        <div class="input">
                          <input type="hidden" name="exam[questions_attributes][' + index + '][type]" value="open" />
                          <input type="text" class="xlarge" name="exam[questions_attributes][' + index + '][question]" />
                        </div>
                      </div>
                      <div class="clearfix">
                        <label style="padding-top: 12px;">Antwoord</label>
                        <div class="input">
                          <div id="wmd-button-bar-' + number + '"></div>
                          <textarea id="wmd-input-' + number + '" class="pull-left" name="exam[questions_attributes][' + index + '][answer]"></textarea>
                          <div id="wmd-preview-' + number + '" class="preview pull-right"></div>
                        </div>
                      </div>' +
                      meta +
                      '<hr />
                    </div>'
    if $(@).attr('id') == 'add-true_false-question'
       template += '<div class="true_false-question">
                      <h3><span>' + number + '. </span><span class="question-title"></span><small>Waarheidsvraag</small></h3>
                      <div class="clearfix">
                        <label>Vraag</label>
                        <div class="input">
                          <input type="hidden" name="exam[questions_attributes][' + index + '][type]" value="true_false" />
                          <input type="text" class="xlarge" name="exam[questions_attributes][' + index + '][question]" />
                        </div>
                      </div>
                      <div class="clearfix">
                        <label>Waar of niet waar</label>
                        <div class="input">
                          <ul class="inputs-list">
                            <li>
                              <label>
                                <input type="radio" value="1" name="exam[questions_attributes][' + index + '][answer]" />
                                <span>Dit is waar.</span>
                              </label>
                            </li>
                            <li>
                              <label>
                                <input type="radio" value="0" name="exam[questions_attributes][' + index + '][answer]" />
                                <span>Dit is niet waar.</span>
                              </label>
                            </li>
                          </ul>
                        </div>
                      </div>' +
                      meta +
                      '<hr />
                    </div>'
    if $(@).attr('id') == 'add-multiple_choice-question'
       template += '<div class="multiple_choice-question">
                      <h3><span>' + number + '. </span><span class="question-title"></span><small>Multiple-choice vraag</small></h3>
                      <div class="clearfix">
                        <label>Vraag</label>
                        <div class="input">
                          <input type="hidden" name="exam[questions_attributes][' + index + '][type]" value="multiple_choice" />
                          <input type="text" class="xlarge" name="exam[questions_attributes][' + index + '][question]" />
                        </div>
                      </div>
                      <div class="clearfix">
                        <label>Antwoorden</label>
                        <div class="input">
                          <div class="input-prepend">
                            <label class="add-on"><span>A </span><input type="radio" name="exam[questions_attributes][' + index + '][answer]" value="0" /></label>
                            <input class="mini" name="exam[questions_attributes][' + index + '][texts][]" size="30" type="text" />
                          </div>
                          <div class="input-prepend">
                            <label class="add-on"><span>B </span><input type="radio" name="exam[questions_attributes][' + index + '][answer]" value="1" /></label>
                            <input class="mini" name="exam[questions_attributes][' + index + '][texts][]" size="30" type="text" />
                          </div>
                          <div class="input-prepend">
                            <label class="add-on"><span>C </span><input type="radio" name="exam[questions_attributes][' + index + '][answer]" value="2" /></label>
                            <input class="mini" name="exam[questions_attributes][' + index + '][texts][]" size="30" type="text" />
                          </div>
                          <div class="input-prepend">
                            <label class="add-on"><span>D </span><input type="radio" name="exam[questions_attributes][' + index + '][answer]" value="3" /></label>
                            <input class="mini" name="exam[questions_attributes][' + index + '][texts][]" size="30" type="text" />
                          </div>
                        </div>
                      </div>' +
                      meta +
                      '<hr />
                    </div>'
    if $(@).attr('id') == 'add-multiple_answers-question'
       template += '<div class="multiple_answers-question">
                      <h3><span>' + number + '. </span><span class="question-title"></span><small>Meerdere antwoorden vraag</small></h3>
                      <div class="clearfix">
                        <label>Vraag</label>
                        <div class="input">
                          <input type="hidden" name="exam[questions_attributes][' + index + '][type]" value="multiple_answers" />
                          <input type="text" class="xlarge" name="exam[questions_attributes][' + index + '][question]" />
                        </div>
                      </div>
                      <div class="clearfix">
                        <label>Antwoorden</label>
                        <div class="input">
                          <div class="input-prepend">
                            <label class="add-on"><span>A </span><input type="checkbox" name="exam[questions_attributes][' + index + '][answers][]" value="0" /></label>
                            <input class="mini" name="exam[questions_attributes][' + index + '][texts][]" size="30" type="text" />
                          </div>
                          <div class="input-prepend">
                            <label class="add-on"><span>B </span><input type="checkbox" name="exam[questions_attributes][' + index + '][answers][]" value="1" /></label>
                            <input class="mini" name="exam[questions_attributes][' + index + '][texts][]" size="30" type="text" />
                          </div>
                          <div class="input-prepend">
                            <label class="add-on"><span>C </span><input type="checkbox" name="exam[questions_attributes][' + index + '][answers][]" value="2" /></label>
                            <input class="mini" name="exam[questions_attributes][' + index + '][texts][]" size="30" type="text" />
                          </div>
                          <div class="input-prepend">
                            <label class="add-on"><span>D </span><input type="checkbox" name="exam[questions_attributes][' + index + '][answers][]" value="3" /></label>
                            <input class="mini" name="exam[questions_attributes][' + index + '][texts][]" size="30" type="text" />
                          </div>
                          <div class="input-prepend">
                            <label class="add-on"><span>E </span><input type="checkbox" name="exam[questions_attributes][' + index + '][answers][]" value="4" /></label>
                            <input class="mini" name="exam[questions_attributes][' + index + '][texts][]" size="30" type="text" />
                          </div>
                          <div class="input-prepend">
                            <label class="add-on"><span>F </span><input type="checkbox" name="exam[questions_attributes][' + index + '][answers][]" value="5" /></label>
                            <input class="mini" name="exam[questions_attributes][' + index + '][texts][]" size="30" type="text" />
                          </div>
                          <div class="input-prepend">
                            <label class="add-on"><span>G </span><input type="checkbox" name="exam[questions_attributes][' + index + '][answers][]" value="6" /></label>
                            <input class="mini" name="exam[questions_attributes][' + index + '][texts][]" size="30" type="text" />
                          </div>
                          <div class="input-prepend">
                            <label class="add-on"><span>H </span><input type="checkbox" name="exam[questions_attributes][' + index + '][answers][]" value="7" /></label>
                            <input class="mini" name="exam[questions_attributes][' + index + '][texts][]" size="30" type="text" />
                          </div>
                        </div>
                      </div>' +
                      meta +
                      '<hr />
                    </div>'
    if $(@).attr('id') == 'add-statements-question'
       template += '<div class="statements-question">
                      <h3><span>' + number + '. </span><span class="question-title"></span><small>Stellingvraag</small></h3>
                      <div class="clearfix">
                        <label>Stelling I</label>
                        <div class="input">
                          <input type="text" class="xlarge" name="exam[questions_attributes][' + index + '][statements][]" />
                        </div>
                      </div>
                      <div class="clearfix">
                        <label>Stelling II</label>
                        <div class="input">
                          <input type="text" class="xlarge" name="exam[questions_attributes][' + index + '][statements][]" />
                        </div>
                      </div>
                      <div class="clearfix">
                        <label>Vraag</label>
                        <div class="input">
                          <input type="hidden" name="exam[questions_attributes][' + index + '][type]" value="statements" />
                          <input type="text" class="xlarge" name="exam[questions_attributes][' + index + '][question]" />
                        </div>
                      </div>
                      <div class="clearfix">
                        <label>Antwoorden</label>
                        <div class="input">
                          <ul class="inputs-list">
                            <li>
                              <label>
                                <input type="radio" value="0" name="exam[questions_attributes][' + index + '][answer]" />
                                <span>Stelling I is waar.</span>
                              </label>
                            </li>
                            <li>
                              <label>
                                <input type="radio" value="1" name="exam[questions_attributes][' + index + '][answer]" />
                                <span>Stelling II is waar.</span>
                              </label>
                            </li>
                            <li>
                              <label>
                                <input type="radio" value="2" name="exam[questions_attributes][' + index + '][answer]" />
                                <span>Beide stellingen zijn waar.</span>
                              </label>
                            </li>
                            <li>
                              <label>
                                <input type="radio" value="3" name="exam[questions_attributes][' + index + '][answer]" />
                                <span>Beide stellingen zijn niet waar.</span>
                              </label>
                            </li>
                          </ul>
                        </div>
                      </div>' +
                      meta +
                      '<hr />
                    </div>'
    $('#exam-questions').append(template)
    if $(@).attr('id') == 'add-open-question'
      window.runEditors() # initialize new markdown editor
    renderTitles() # render new titles
    false
  # quick n dirty question additions and templating in question form
  $('.type input[type=radio]').click ->
    $('.open-question, .true_false-question, .multiple_choice-question , .multiple_answers-question, .statements-question').remove()
    type = $(@).val()
    meta = '<div class="clearfix">
              <label>Moeilijkheid</label>
              <div class="input">
                <input type="text" class="span1" name="question[difficulty]" value="5" /><span> uit 10</span>
              </div>
            </div>
            <div class="clearfix">
              <label>Tijdsduur</label>
              <div class="input">
                <input type="text" class="span1" name="question[time]" value="5" /><span> minuten</span>
              </div>
            </div>'
    template = ''
    if type == 'open'
       template += '<div class="open-question">
                      <h3><span class="question-title"></span><small>Open vraag</small></h3>
                      <div class="clearfix">
                        <label>Vraag</label>
                        <div class="input">
                          <input type="hidden" name="question[type]" value="open" />
                          <input type="text" class="xlarge" name="question[question]" />
                        </div>
                      </div>
                      <div class="clearfix">
                        <label style="padding-top: 12px;">Antwoord</label>
                        <div class="input">
                          <div id="wmd-button-bar-0"></div>
                          <textarea id="wmd-input-0" class="pull-left" name="question[answer]"></textarea>
                          <div id="wmd-preview-0" class="preview pull-right"></div>
                        </div>
                      </div>' +
                      meta +
                      '<hr />
                    </div>'
    if type == 'true_false'
       template += '<div class="true_false-question">
                      <h3><span class="question-title"></span><small>Waarheidsvraag</small></h3>
                      <div class="clearfix">
                        <label>Vraag</label>
                        <div class="input">
                          <input type="hidden" name="question[type]" value="true_false" />
                          <input type="text" class="xlarge" name="question[question]" />
                        </div>
                      </div>
                      <div class="clearfix">
                        <label>Waar of niet waar</label>
                        <div class="input">
                          <ul class="inputs-list">
                            <li>
                              <label>
                                <input type="radio" value="1" name="question[answer]" />
                                <span>Dit is waar.</span>
                              </label>
                            </li>
                            <li>
                              <label>
                                <input type="radio" value="0" name="question[answer]" />
                                <span>Dit is niet waar.</span>
                              </label>
                            </li>
                          </ul>
                        </div>
                      </div>' +
                      meta +
                      '<hr />
                    </div>'
    if type == 'multiple_choice'
       template += '<div class="multiple_choice-question">
                      <h3><span class="question-title"></span><small>Multiple-choice vraag</small></h3>
                      <div class="clearfix">
                        <label>Vraag</label>
                        <div class="input">
                          <input type="hidden" name="question[type]" value="multiple_choice" />
                          <input type="text" class="xlarge" name="question[question]" />
                        </div>
                      </div>
                      <div class="clearfix">
                        <label>Antwoorden</label>
                        <div class="input">
                          <div class="input-prepend">
                            <label class="add-on"><span>A </span><input type="radio" name="question[answer]" value="0" /></label>
                            <input class="mini" name="question[texts][]" size="30" type="text" />
                          </div>
                          <div class="input-prepend">
                            <label class="add-on"><span>B </span><input type="radio" name="question[answer]" value="1" /></label>
                            <input class="mini" name="question[texts][]" size="30" type="text" />
                          </div>
                          <div class="input-prepend">
                            <label class="add-on"><span>C </span><input type="radio" name="question[answer]" value="2" /></label>
                            <input class="mini" name="question[texts][]" size="30" type="text" />
                          </div>
                          <div class="input-prepend">
                            <label class="add-on"><span>D </span><input type="radio" name="question[answer]" value="3" /></label>
                            <input class="mini" name="question[texts][]" size="30" type="text" />
                          </div>
                        </div>
                      </div>' +
                      meta +
                      '<hr />
                    </div>'
    if type == 'multiple_answers'
       template += '<div class="multiple_answers-question">
                      <h3><span class="question-title"></span><small>Meerdere antwoorden vraag</small></h3>
                      <div class="clearfix">
                        <label>Vraag</label>
                        <div class="input">
                          <input type="hidden" name="question[type]" value="multiple_answers" />
                          <input type="text" class="xlarge" name="question[question]" />
                        </div>
                      </div>
                      <div class="clearfix">
                        <label>Antwoorden</label>
                        <div class="input">
                          <div class="input-prepend">
                            <label class="add-on"><span>A </span><input type="checkbox" name="question[answers][]" value="0" /></label>
                            <input class="mini" name="question[texts][]" size="30" type="text" />
                          </div>
                          <div class="input-prepend">
                            <label class="add-on"><span>B </span><input type="checkbox" name="question[answers][]" value="1" /></label>
                            <input class="mini" name="question[texts][]" size="30" type="text" />
                          </div>
                          <div class="input-prepend">
                            <label class="add-on"><span>C </span><input type="checkbox" name="question[answers][]" value="2" /></label>
                            <input class="mini" name="question[texts][]" size="30" type="text" />
                          </div>
                          <div class="input-prepend">
                            <label class="add-on"><span>D </span><input type="checkbox" name="question[answers][]" value="3" /></label>
                            <input class="mini" name="question[texts][]" size="30" type="text" />
                          </div>
                          <div class="input-prepend">
                            <label class="add-on"><span>E </span><input type="checkbox" name="question[answers][]" value="4" /></label>
                            <input class="mini" name="question[texts][]" size="30" type="text" />
                          </div>
                          <div class="input-prepend">
                            <label class="add-on"><span>F </span><input type="checkbox" name="question[answers][]" value="5" /></label>
                            <input class="mini" name="question[texts][]" size="30" type="text" />
                          </div>
                          <div class="input-prepend">
                            <label class="add-on"><span>G </span><input type="checkbox" name="question[answers][]" value="6" /></label>
                            <input class="mini" name="question[texts][]" size="30" type="text" />
                          </div>
                          <div class="input-prepend">
                            <label class="add-on"><span>H </span><input type="checkbox" name="question[answers][]" value="7" /></label>
                            <input class="mini" name="question[texts][]" size="30" type="text" />
                          </div>
                        </div>
                      </div>' +
                      meta +
                      '<hr />
                    </div>'
    if type == 'statements'
       template += '<div class="statements-question">
                      <h3><span class="question-title"></span><small>Stellingvraag</small></h3>
                      <div class="clearfix">
                        <label>Stelling I</label>
                        <div class="input">
                          <input type="text" class="xlarge" name="question[statements][]" />
                        </div>
                      </div>
                      <div class="clearfix">
                        <label>Stelling II</label>
                        <div class="input">
                          <input type="text" class="xlarge" name="question[statements][]" />
                        </div>
                      </div>
                      <div class="clearfix">
                        <label>Vraag</label>
                        <div class="input">
                          <input type="hidden" name="question[type]" value="statements" />
                          <input type="text" class="xlarge" name="question[question]" />
                        </div>
                      </div>
                      <div class="clearfix">
                        <label>Antwoorden</label>
                        <div class="input">
                          <ul class="inputs-list">
                            <li>
                              <label>
                                <input type="radio" value="0" name="question[answer]" />
                                <span>Stelling I is waar.</span>
                              </label>
                            </li>
                            <li>
                              <label>
                                <input type="radio" value="1" name="question[answer]" />
                                <span>Stelling II is waar.</span>
                              </label>
                            </li>
                            <li>
                              <label>
                                <input type="radio" value="2" name="question[answer]" />
                                <span>Beide stellingen zijn waar.</span>
                              </label>
                            </li>
                            <li>
                              <label>
                                <input type="radio" value="3" name="question[answer]" />
                                <span>Beide stellingen zijn niet waar.</span>
                              </label>
                            </li>
                          </ul>
                        </div>
                      </div>' +
                      meta +
                      '<hr />
                    </div>'
    $('fieldset .actions').after(template)
    if type == 'open'
      window.runEditors() # initialize new markdown editor
    renderTitles() # render new titles
  # initialize questions on page load
  if $('body').attr('id') is 'questions' and $('body').attr('data-action') is 'index'
    filterQuestions()
    # bind filter events
    $('#search').keyup -> filterQuestions()
    $('#types-list input, #average_difficulty, #amount_of_time').change -> filterQuestions()

# render question titles
renderTitles = ->
  $('.open-question .xlarge').keyup ->
    $(@).closest('.open-question').find('h3 span.question-title').text($(@).val() + ' ')
  $('.true_false-question .xlarge').keyup ->
    $(@).closest('.true_false-question').find('h3 span.question-title').text($(@).val() + ' ')
  $('.multiple_choice-question .xlarge').keyup ->
    $(@).closest('.multiple_choice-question').find('h3 span.question-title').text($(@).val() + ' ')
  $('.multiple_answers-question .xlarge').keyup ->
    $(@).closest('.multiple_answers-question').find('h3 span.question-title').text($(@).val() + ' ')
  $('.statements-question .xlarge').last().keyup ->
    $(@).closest('.statements-question').find('h3 span.question-title').text($(@).val() + ' ')

# serialize filter form and retrieve questions accordingly
filterQuestions = () ->
  $('#questions-list').children(':not(.spinner)').remove()
  $('.span11 h2 small').empty()
  $('#questions-list .spinner').show()
  # cancel any current ajax request
  window.stop()
  # get questions with filters applied
  $.getJSON('/questions?' + $('#filters form').serialize(), (data) -> buildQuestionsList(data))

# quick n dirty templating of questions list
buildQuestionsList = (data) ->
  template = ''
  if data.length is 0
    template += '<p>Geen vragen gevonden.</p>'
  else
    months = ['januari', 'februari', 'maart', 'april', 'mei', 'juni', 'juli', 'augustus', 'september', 'oktober', 'november', 'december']
    for item in data
      date = item.created_at.substr(0, 10).split('-')
      date = date[2] + ' ' + months[(date[1] - 1)] + ' ' + date[0]
      type = 'Open vraag' if item.type is 'open'
      type = 'Multiple-choice vraag' if item.type is 'multiple_choice'
      type = 'Meerdere antwoorden vraag' if item.type is 'multiple_answers'
      type = 'Waarheidsvraag' if item.type is 'true_false'
      type = 'Stellingvraag' if item.type is 'statements'
      template += '<div class="question-item">
                    <h3 class="pull-left"><a href="/questions/' + item._id + '/edit">' + item.question + '</a> <small>' + type + '</small></h3>
                    <table class="condensed-table">
                      <tr><td>Tijdsduur:</td><td>' + item.time + ' minuten</td><td>Moeilijkheid:</td><td>' + item.difficulty + ' uit 10</td></tr>
                      <tr><td>Gemaakt op:</td><td>' + date + '</td><td>Gemaakt door:</td><td>' + item.author + '</td></tr>
                    </table>
                  </div>'
  $('.span11 h2 small').text(data.length + ' gevonden') if data.length > 0
  $('#questions-list .spinner').hide()
  $('#questions-list .spinner').after(template)

