// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-validate/jquery.validate.min
//= require jquery-validate/messages_zh
//= require jquery-validate/extend
//= require turbolinks
//= require_tree .
//= require underscore.min
//= require gmaps/google
//= require jquery.raty
//= require ratyrate

$(function(){

  $("#obtainVerifyCode").click(function(){
    var phone = $("#user_cellphone").val();
    $.ajax({
      url:'/sms/create_verify_code',
      type:'POST',
      data:{
        phone: phone
        //_rucaptcha: captcha
      }
    });
  });

// prepare form validate
  $("#prepare_form").validate({
    rules: {
      cellphone: {
        required: true,
        isMobile: true
      },
      _rucaptcha: {
        required: true,
        rangelength:[4,4]
      }
    },
    messages: {
			_rucaptcha: {
				rangelength: "验证码长度为4位字符"
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

  // sign up form validate
    $("#new_user").validate({
      rules: {
        'user[nickname]': {
          required: true,
          stringCheck: true,
          byteRangeLength:[2,16]
        },
        'user[password]': {
          required: true,
          isPassword: true,
          rangelength:[6,15]
        },
        'user[validate_code]': {
          required: true,
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

    // sign in form validate
    $("#signin_user").validate({
      rules: {
        'user[cellphone]': {
          required: true,
          isMobile: true
        },
        'user[password]': {
          required: true,
          isPassword: true,
          rangelength:[6,15]
        }
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
    // reset password form validate
    $("#reset_password_form").validate({
      rules: {
        'user[cellphone]': {
          required: true,
          isMobile: true
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
        'user[validate_code]': {
          required: true,
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

function validate_code_time(code_id, wait) {
  var code_button = $("#"+code_id);
  if (wait == 0) {
    code_button.removeAttr("disabled");
    code_button.val("获取验证码");
  } else {
    code_button.attr("disabled", true);
    code_button.html("重新发送(" + wait + ")");
    wait = wait-1;
    setTimeout(function() {
      validate_code_time(code_id, wait)
    },
    1000)
  }
}
