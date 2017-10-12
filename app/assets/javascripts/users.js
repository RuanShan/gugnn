// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$(function(){

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
  newUserValidator= $("#new_user_form").validate({
      rules: {
        'user[cellphone]': {
          required: true,
          isMobile: true,
          remote: {
              url: Gugnn.routes.validate_cellphone_path,     //后台处理程序
              type: "get",               //数据发送方式
              dataType: "json",           //接受数据格式
              data: {                     //要传递的数据
                  cellphone: function() {
                      return $("#user_cellphone").val();
                  }
              }
          }
        },
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
        'user[verification_code]': {
          required: true,
          rangelength:[6,6]
        },
      },
      messages: {
        'user[cellphone]': {
          remote: "电话号码已注册，请使用其他号码。",
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
    var newSessionValidator= $("#new_session_form").validate({
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

    $("#new_user_form #obtainVerifyCode").click(function(){
      var cellphoneSelector = '#new_user_form #user_cellphone';
      var self = this;//发短信按键

      var validCellphone = newUserValidator.element(cellphoneSelector)
      if ( validCellphone ) {
        var cellphone = $(cellphoneSelector).val();
      		Gugnn.common.getVerifyCode({
      									disabled:"重新获取",
      									text:"重新发送",
      									time:60,
      									sendHint:true, //是否提示
      									sendText:"动态验证码已发送到您的手机，10分钟内有效", // 提示文本
       									ctx: self,
      									auth:{
      										url: Gugnn.routes.sms_path,
      										data:{
      											"cellphone": cellphone,
      										}
      									}
      								});
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
        'user[verification_code]': {
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
