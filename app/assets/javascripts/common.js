(function(window) {
	var c = { //通用的方法类
    //倒计时
     getTime: function(i, that, fn, num) { // i : 从哪个时间开始倒计时, that : 哪个对象进行显示时间 , fn : 倒计时要执行的函数, num: 延时
      that.text(i);
      var time = setInterval(function() {
        that.text(--i);
        i <= 0 ? (
          $.isFunction(fn) ? fn() : null,
          clearInterval(time),
          time = null
        ) : null;
      }, num || 1000);

      time;
    },
     validataSmsCode:function(obj) {//验证手机验证码
        var data = {
            "activate": obj.activate,
            "type": obj.type,
            "phone": obj.phone
          };

      $.ajax({
        url: ctx + "/sms/validataSmsCode",
        data: data,
        type: "POST",
        dataType: "json",
        success: function(data){
          obj.fn(data);
        },
        error:function(xhr, error, msg){
          console.info(msg);
        }
      });
    },
     getVerifyCode:function( obj ){
			 // ctx: 发送信息的按钮，
       // time:重新发送倒计时秒数, text: 重新允许发送后的提示信息, disabled:禁止后的提示信息
			 // auth.url: 请求验证码的路径, auth.data：请求验证码的数据
      $(obj.ctx)
        .html("<span class='time'></span>s后" + obj.disabled + "")
        .prop("disabled", true);

      Gugnn.common.getTime(obj.time, $(".time"), function() {
        $(obj.ctx).html(obj.text).prop("disabled", false);
      });

      $.post(obj.auth.url, obj.auth.data, function(response){
				console.log(response );
				if( response.status ==1 )
				{
					//weui.toast('验证短信已发送！',2000);
				}	else{
					//weui.alert('短信发送失败，请联系客服！');
				}
			},"json");
    },
	}
  Gugnn.common = c;
  window.gugnnCommon = c;
})(window);
