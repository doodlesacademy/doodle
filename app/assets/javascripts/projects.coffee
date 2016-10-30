(($, window) -> $ ->
  project_slug = null
  level = null
  $academy_modal = $('#academy-select')

  setupListeners = ->
    $('body').on 'click', '[data-toggle="modal"]', openModal
    $academy_modal.on 'click', '.btn-academy', selectAcademy
    $('.project-grid').on 'click', '.project-grid-item', selectProject

  selectProject = (e) ->
    $project = $ e.currentTarget
    project_slug = $project.data('project-slug')
    project_id = $project.attr('id')
    $('#academy-select').find('.modal-content').attr('id', project_id)
    unit_full_title = $project.data('unit-full-title')
    $('#unit-full-title-modal').text(unit_full_title)
    project_title = $project.data('project-title')
    $('#project-title-modal').text('PROJECT : ' + project_title)
    project_synopsis = $project.data('project-synopsis')
    $('#project-synopsis-modal').text(project_synopsis)
    project_featured_image = $project.data('project-featured-image')
    $('#project-featured-image-modal').attr('src', project_featured_image)
    lower_project_id = $project.data('project-lower-id')
    upper_project_id = $project.data('project-upper-id')
    favorite_lower = $project.data('favorite-lower')
    favorite_upper = $project.data('favorite-upper')

    fave_star_lower = $('#modal-lower-favorite-star')
    if favorite_lower
      console.log('this is a favorite')
      $('#modal-lower-favorite-star span').removeClass('glyphicon glyphicon-star glyphicon-star-empty')
      $('#modal-lower-favorite-star span').addClass('glyphicon glyphicon-star')
      fave_star_lower.attr('href', '/projects/' + lower_project_id + '/favorite?type=unfavorite')
    else
      console.log('this is NOT a favorite')
      $('#modal-lower-favorite-star span').removeClass('glyphicon glyphicon-star glyphicon-star-empty')
      $('#modal-lower-favorite-star span').addClass('glyphicon glyphicon-star-empty')
      fave_star_lower.attr('href', '/projects/' + lower_project_id + '/favorite?type=favorite')
    toggleAcademyModal(true)

    fave_star_upper = $('#modal-upper-favorite-star')
    if favorite_upper
      console.log('this is a favorite')
      $('#modal-upper-favorite-star span').removeClass('glyphicon glyphicon-star glyphicon-star-empty')
      $('#modal-upper-favorite-star span').addClass('glyphicon glyphicon-star')
      fave_star_upper.attr('href', '/projects/' + upper_project_id + '/favorite?type=unfavorite')
    else
      console.log('this is NOT a favorite')
      $('#modal-upper-favorite-star span').removeClass('glyphicon glyphicon-star glyphicon-star-empty')
      $('#modal-upper-favorite-star span').addClass('glyphicon glyphicon-star-empty')
      fave_star_upper.attr('href', '/projects/' + upper_project_id + '/favorite?type=favorite')
    toggleAcademyModal(true)

  selectAcademy = (e) ->
    $academy = $ e.currentTarget
    level = $academy.data('level')
    location = window.location.toString()
    location = location.replace('projects', "#{level}/projects")
    window.location = "#{location}/#{project_slug}"
    toggleAcademyModal()

  toggleModal = ($modal, toggle=false) ->
    $modal.toggleClass 'is-active', toggle
    $modal.on 'click.close-modal', '.modal-close', (e) ->
      toggleModal($modal)
      $modal.off '.close-modal'

  toggleAcademyModal = (toggle) ->
    toggleModal($academy_modal, toggle)

  openModal = (e) ->
    $modal_link = $ e.currentTarget
    modal_id = $modal_link.data('modal-id')
    $modal = $ "##{modal_id}"
    toggleModal($modal, true)

  setupListeners()

)(window.$ or window.jQuery or window.Zepto, window)
