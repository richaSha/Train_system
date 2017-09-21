$(document).ready(function(){
  $('.container-fluid').css('height' , $(window).height()- $('.jumbotron').innerHeight());

  $('.new_user').click(function(){
    $('.signup_form').toggleClass("hide")
    $('.login_form').toggleClass("hide")
  })
})
