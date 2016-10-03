(($, window) -> $ ->

  $('#pencil-name').click ->
    $('#edit-name').toggle()
    return

  $('#pencil-classroom').click ->
    $('#edit-classroom-data').toggle()
    $('#classroom-data').toggle()
    return

  $('#camera-icon').click ->
    $('#user_profile_attributes_avatar').trigger 'click'
    return

  $('#user_profile_attributes_avatar').change ->
      $('#update-avatar').trigger 'click'
    return


)(window.$ or window.jQuery or window.Zepto, window)
