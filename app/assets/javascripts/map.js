$(function(){
  if( $('.my form.product-form').is('*'))
  {
    var address_container_id="address_container";
    // 创建|编辑 商品时， 初始化租赁商品的地址
      var $lng = $("#product_lng");
      var $lat= $("#product_lat");
      var $city_name = $('#product_city_name');
      var option = { 'lat': $lat.val(), 'lng': $lng.val() };
      var product_address_map = new AddressAmap(address_container_id, option);

      $('#submit_address_btn').click(function(){
        if( product_address_map.marker )
        {
          var position = product_address_map.marker.getPosition();
          $('#product_latlng_address').val( product_address_map.address);
          $lat.val(position.getLat());
          $lng.val(position.getLng());
          $city_name.val( product_address_map.city);
          $('#gugnnMapModal').modal('hide');
        }else{

        }

      })
      //在创建和编辑商品页面，用户点击‘地址’，弹出地图对话框
      if( $('input#product_latlng_address').is('*'))
      {
        $('#product_latlng_address').click(function(){
          $('#gugnnMapModal').modal('show');
        })
      }
  }
  //浏览商品时，初始化地图
  var map_container_id="product_map_container";
  if( $('#'+map_container_id).is('*'))
  {
    var lng = parseFloat( $("#product_lng").val() );
    var lat= parseFloat( $("#product_lat").val());
    if( lng && lat)
    {
      var option = { 'lat': lat, 'lng': lng };
      var map_options = { 'scrollWheel': false };
      var product_address_map = new AddressAmap(map_container_id, option, map_options);
    }else {
      $('#'+map_container_id).html("这个商品没有位置信息。");
    }
  }
})

// params
//  container_id: html element id
//  options: keys [ lat,lng ]
function AddressAmap(container_id, options, map_options){
  this.options= options||{};
  this.map_options = map_options || {};
  this.container_id = container_id;
  this.address = null;
  this.addressComponent  = null;
  this.init();
}

AddressAmap.prototype.init = function(){
  this.map = new AMap.Map(this.container_id, this.map_options);
  var current_map = this.map;
  AMap.plugin(['AMap.ToolBar'],
    function(){
        current_map.addControl(new AMap.ToolBar());
  });
  this.geocoder = new AMap.Geocoder({ radius: 1000, extensions: "all"});

  var map = this.map;
  var self = this;
  var lat = this.options.lat;
  var lng = this.options.lng
  if( parseFloat(lng)>0 && parseFloat(lat)>0)
  {
    //大连中心经纬度： 121.59347778,38.94870994
    map.setZoomAndCenter(14, [lng, lat]);

    this.marker = new AMap.Marker({
                map: map,
                position: [lng, lat]
    });// 创建标注
  }else{
    map.setCity(Gugnn.city);

  }
  //为地图注册click事件获取鼠标点击出的经纬度坐标
  var clickEventListener = map.on('click', function(e) {
    self.clickCallback( e );
  });
};
AddressAmap.prototype.clickCallback = function(e){
  var self = this;

  this.address = null;
  //  document.getElementById("lnglat").value = e.lnglat.getLng() + ',' + e.lnglat.getLat()
  if( this.marker )
  {
    this.marker.setPosition(e.lnglat); //更新点标记位置
  }else {
    this.marker = new AMap.Marker({
                map: this.map,
                position: [e.lnglat.getLng(), e.lnglat.getLat()]
    });// 创建标注
  }
  this.geocoder.getAddress(this.marker.getPosition( ), function(status, result) {
      if (status === 'complete' && result.info === 'OK') {
        self.geocoderCallback( result );
      }
  });
};
AddressAmap.prototype.geocoderCallback = function( result){
  //addressComponent
  //adcode:110105, building:"", buildingType:"", businessAreas:(3) [{…}, {…}, {…}]
  //city:"",citycode:"010",district:"朝阳区",neighborhood:"",neighborhoodType:""
  //province:"北京市",street:"北四环中路",streetNumber:"24号"
  //township:"奥运村街道"
  this.addressComponent = result.regeocode.addressComponent;
  this.address = result.regeocode.formattedAddress; //返回地址描述
  this.city = this.addressComponent.city.length > 0 ? this.addressComponent.city : this.addressComponent.province
};




function baidu_address_container(instance)
{
  var lng = $("#"+instance+"_lng").val();
  var lat= $("#"+instance+"_lat").val();
  var city = Gugnn.city;

  var map = new BMap.Map("address_container");  // 创建地图实例
  map.addControl(new BMap.NavigationControl());
  map.addControl(new BMap.ScaleControl());
  map.enableAutoResize();

  if( parseFloat(lng)>0 && parseFloat(lat)>0)
  {
    //大连中心经纬度： 121.59347778,38.94870994
    var point = new BMap.Point(lng, lat);  // 创建点坐标
    map.centerAndZoom(point, 15);
    var marker = new BMap.Marker(point);        // 创建标注
    map.addOverlay(marker);
    marker.enableDragging();
    marker.addEventListener("dragend", function(e){
      $("#"+instance+"_lat").val(e.point.lat);
      $("#"+instance+"_lng").val(e.point.lng);
      $("#marked").removeClass()
      $("#marked").addClass("glyphicon glyphicon-ok")
    })
  }else{
    map.centerAndZoom(city, 11);
  }
  map.addEventListener('resize', function(){
    console.log(this.getCenter().lng + ',' + this.getCenter().lat);
  });
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
}
