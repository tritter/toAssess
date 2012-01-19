$ ->
  renderTitles()
  $('#add-open-question, #add-true_false-question, #add-multiple_choice-question, #add-multiple_answers-question, #add-statements-question').click ->
    user_id = $('#exam-user-id').val()
    index = parseInt($('#exam-questions > div').last().find('h3 span').text()) || 0
    number = index + 1;
    meta = '<div class="clearfix">
              <div class="input">
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
      window.runEditors()
    renderTitles()
    false

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

