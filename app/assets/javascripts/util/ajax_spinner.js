//https://www.cnblogs.com/baiyunchen/p/5424610.html
//= require layer.custom
$(function () {
            $.ajaxSetup({
                layerIndex:-1,
                beforeSend: function () {
                    this.layerIndex = layer.load(2, { shade: [0.5, '#c0c0c0'] });
                },
                complete: function () {
                    layer.close(this.layerIndex);
                },
                error: function () {
                    layer.alert('部分数据加载失败，可能会导致页面显示异常，请刷新后重试', {
                        skin: 'layui-layer-molv'
                       , closeBtn: 0
                       , shift: 4 //动画类型
                    });
                }
            });
});
