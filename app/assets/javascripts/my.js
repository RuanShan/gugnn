//= require application
//= require jquery-fileupload

var CurrentMap=null;
$(function(){
  $(".dropdown-toggle").dropdown();

  $(document).on('show.bs.modal', '#gugnnModal', function (event) {
    var button = $(event.relatedTarget); // Button that triggered the modal
    var title = button.data('title'); // Extract info from data-* attributes
    var ajax_url = button.data('ajax_url'); // Extract info from data-* attributes
    var ajax_callback = button.data('ajax_callback'); // Extract info from data-* attributes
    var modal = $(this);
    modal.find('.modal-title').text(title);
    modal.find('.modal-body').load(ajax_url, function(){eval(ajax_callback);});
  });

  $("#systemImgBox img").click(function(){
    var image_url = $(this).attr('src');
    $("#defaultImgLiBorder img").attr("src", image_url);
    $("#user_avatar_remote_url").val(image_url);
  });

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

  // authentication form validate
  $("#authentication_form").validate({
    rules: {
      'user[shop_name]': {
        required: true,
        stringCheck: true,
        rangelength:[6,50]
      },
      'user[id_number]': {
        required: true,
        isIdCardNo: true
      },
      //'user[id_photo]': {
      //  required: true,
      //},
      //'user[shop_photo]': {
      //  required: true,
      //},
      'user[city]': {
        required: true,
        rangelength:[2,10]
      },
      'user[shop_address]': {
        required: true,
        rangelength:[6,20]
      },
      'user[contact_person]': {
        required: true,
        rangelength:[2,10]
      },
      'user[contact_phone]': {
        required: true,
        //isTel: true
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

//product_form validate
  $("#new_product").validate({
    rules: {
      'product[title]': {
        required: true,
        rangelength:[6,50]
      },
      'product[desc]': {
        rangelength:[10,2000]
      },
      'product[price]': {
        required: true,
        digits:true,
        min:0
      },
      'product[address]': {
        rangelength:[6,20]
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

function mark_address(instance){
  //if(CurrentMap==null){
    var lng = $("#"+instance+"_lng").val();
    var lat= $("#"+instance+"_lat").val();
    if(lng){}else{lng=116.404;}
    if(lat){}else{lat=39.915;}
    var map = new BMap.Map("address_container");  // 创建地图实例
    map.addControl(new BMap.NavigationControl());
    map.addControl(new BMap.ScaleControl());
    var point = new BMap.Point(lng, lat);  // 创建点坐标
    map.centerAndZoom(point, 15);
    var marker = new BMap.Marker(point);        // 创建标注
    map.addOverlay(marker);
    map.addEventListener("click", function(e){
      var pt = new BMap.Point(e.point.lng, e.point.lat);
      map.clearOverlays();
      var mk = new BMap.Marker(pt);
      map.addOverlay(mk);
      $("#"+instance+"_lat").val(e.point.lat);
      $("#"+instance+"_lng").val(e.point.lng);
      $("#marked").removeClass()
      $("#marked").addClass("glyphicon glyphicon-ok")
    });
    marker.enableDragging();
    marker.addEventListener("dragend", function(e){
      $("#"+instance+"_lat").val(e.point.lat);
      $("#"+instance+"_lng").val(e.point.lng);
      $("#marked").removeClass()
      $("#marked").addClass("glyphicon glyphicon-ok")
    })
    //CurrentMap=map;
  //}
}

function cancel_file(index){
  var input_num = $("#selected_files").children().length+$(".files").children(".existed_image").length;
  $("#product_images_attributes_"+index+"_photo").remove();
  for(var i=index+1; i<=input_num; i++){
    $("#product_images_attributes_"+i+"_photo").prop('name',"product[images_attributes]["+(i-1)+"][photo]").prop('id',"product_images_attributes_"+(i-1)+"_photo");
  }
}

function delete_file(index, image_id){
  $("#product_images_attributes_"+index+"__destroy").val("true");
  $("#image_"+image_id).hide();
}
