function validateForm() {
  user_name = $('.new_user_name').val().trim();
  confirm_password = $('.confirm_password').val().trim();
  password = $('.signup_password').val().trim();
  if ((confirm_password != password) || (password =="") || (user_name== "")){
    alert("false")
    return false;
  } else {
    $('.signup-error').text() = "Sorry invalid credentials";
    return true;
  }
}

function validateLoginForm() {
  user_name = $('.login_user').val().trim();
  password = $('.login_password').val().trim();
  if ((password =="") || (user_name== "")){
    return false;
  } else {
    $('.login-error').text() = "Sorry invalid credentials";
    return true;
  }
}
$(document).ready(function(){
  

  $('.container-fluid').css('height' , $(window).height()- $('.jumbotron').innerHeight());

  $('.new_user').click(function(){
    $('.signup_form').toggleClass("hide")
    $('.login_form').toggleClass("hide")
  })
  $('.form-control').focus(function(){
    $('.login-error').text() = "";
    $('.signup-error').text() = "";
    $('.alert').addClass('hideItem');
  })

})
