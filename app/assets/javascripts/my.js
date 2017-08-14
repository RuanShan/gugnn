//= require application

$(function(){
  $(".dropdown-toggle").dropdown();

  // change password form validate
  $("#change_password_form").validate({
    rules: {
      'user[current_password]': {
        required: true,
        isPassword: true,
        rangelength:[6,15]
      },
      'user[password]': {
        required: true,
        isPassword: true,
        rangelength:[6,15]
      },
      'user[password_confirmation]': {
        required: true,
        equalTo: '#reset_password_form #user_password'
      },
    },
    errorPlacement:function(error,element) {
      var position = element.position();
      error.css({
        "position" : "absolute",
        "line-height" : "15px",
        "font-weight" : "normal",
        "top" : position.top+34,
        "left": position.left,
        "color": "red"
      })
      error.appendTo(element.parent());
    }

  });

  // change profile form validate
  $("#change_profile_form").validate({
    rules: {
      'user[nickname]': {
        required: true,
        stringCheck: true,
        byteRangeLength:[2,16]
      },
      'user[cellphone]': {
        required: true,
        isMobile: true
      },
      'user[validate_code]': {
        //required: true,
        rangelength:[5,6]
      },
    },
    errorPlacement:function(error,element) {
      var position = element.position();
      error.css({
        "position" : "absolute",
        "line-height" : "15px",
        "font-weight" : "normal",
        "top" : position.top+34,
        "left": position.left,
        "color": "red"
      })
      error.appendTo(element.parent());
    }

  });


});
