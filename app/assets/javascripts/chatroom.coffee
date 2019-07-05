# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

image_post = ->
# Display the image to be uploaded.
  $('.file-input').on 'change', (e) ->
    displayImage = URL.createObjectURL(event.target.files[0])
    $('.image-div').show()
    $('.image-div').css({"background-image" : "url(" + "#{displayImage}" + ")", "background-size":"cover"})



$(document).ready(
  image_post
)