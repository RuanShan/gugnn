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

function toggle_category(category_id){
  $(".cat").removeClass("active");
  $("#cat_"+category_id).addClass("active");
  $(".sub_cat").hide();
  $("#sub_cat_"+category_id).show();
}

function mark_address(){
  var map = new BMap.Map("address_container");  // 创建地图实例
  map.addControl(new BMap.NavigationControl());
  map.addControl(new BMap.ScaleControl());
  var point = new BMap.Point(116.404, 39.915);  // 创建点坐标
  map.centerAndZoom(point, 15);
  var marker = new BMap.Marker(point);        // 创建标注
  map.addOverlay(marker);
  map.addEventListener("click", function(e){
    var pt = new BMap.Point(e.point.lng, e.point.lat);
    map.clearOverlays();
    var mk = new BMap.Marker(pt);
    map.addOverlay(mk);
    $("#product_lat").val(e.point.lat);
    $("#product_lng").val(e.point.lng);
    $("#marked").removeClass()
    $("#marked").addClass("glyphicon glyphicon-pushpin")
  });
  marker.enableDragging();
  marker.addEventListener("dragend", function(e){
    $("#product_lat").val(e.point.lat);
    $("#product_lng").val(e.point.lng);
  })
}
