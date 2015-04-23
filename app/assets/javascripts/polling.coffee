window.Poll = ->
  setTimeout ->
    $.get('/comments')
  , 5000
 
jQuery ->
  Poll() if $('#comments').size() > 0