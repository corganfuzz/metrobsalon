	
#= require active_admin/base

$ ->
  flashCallback = ->
    $("#flash_notice").fadeOut()
  $("#flash_notice").bind 'click', (ev) =>
    $("#flash_notice").fadeOut()
  setTimeout flashCallback, 2000

  $ ->
  flashCallback = ->
    $("#flash_alert").fadeOut()
  $("#flash_alert").bind 'click', (ev) =>
    $("#flash_alert").fadeOut()
  setTimeout flashCallback, 3000

  $ ->
  flashCallback = ->
    $("#flash_error").fadeOut()
  $("#flash_error").bind 'click', (ev) =>
    $("#flash_error").fadeOut()
  setTimeout flashCallback, 3000

  $ -> 
  flashCallback = ->
    $(".flashes").fadeOut()
  $(".flashes").bind 'click', (ev) =>
    $(".flashes").fadeOut()
  setTimeout flashCallback, 3000


