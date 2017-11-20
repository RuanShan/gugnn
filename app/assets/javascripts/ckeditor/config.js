
CKEDITOR.editorConfig = function (config) {
  // Define changes to default configuration here. For example:
  // config.language = 'fr';
  // config.uiColor = '#AADC6E';

  /* Filebrowser routes */
  // The location of an external file browser, that should be launched when "Browse Server" button is pressed.
  config.filebrowserBrowseUrl = "/ckeditor/attachment_files";

  // The location of an external file browser, that should be launched when "Browse Server" button is pressed in the Flash dialog.
  config.filebrowserFlashBrowseUrl = "/ckeditor/attachment_files";

  // The location of a script that handles file uploads in the Flash dialog.
  config.filebrowserFlashUploadUrl = "/ckeditor/attachment_files";

  // The location of an external file browser, that should be launched when "Browse Server" button is pressed in the Link tab of Image dialog.
  config.filebrowserImageBrowseLinkUrl = "/ckeditor/pictures";

  // The location of an external file browser, that should be launched when "Browse Server" button is pressed in the Image dialog.
  config.filebrowserImageBrowseUrl = "/ckeditor/pictures";

  // The location of a script that handles file uploads in the Image dialog.
  config.filebrowserImageUploadUrl = "/ckeditor/pictures?";

  // The location of a script that handles file uploads.
  config.filebrowserUploadUrl = "/ckeditor/attachment_files";

  config.allowedContent = true;

  //config.toolbar_mini = [
  //  ["Bold",  "Italic",  "Underline",  "Strike",  "-",  "Subscript",  "Superscript"],
  //];
  //http://www.jianshu.com/p/86454de1eae4
  //config.toolbarGroups = [
  //  { name: 'clipboard',   groups: [ 'clipboard', 'undo' ] },
  //  { name: 'editing',     groups: [ 'find', 'selection', 'spellchecker' ] },
  //  { name: 'links' },
  //  { name: 'insert' },
  //  //{ name: 'forms' },
  //  { name: 'tools' },
  //  //{ name: 'document',    groups: [ 'mode', 'document', 'doctools' ] },
  //  { name: 'others' },
  //  '/',
  //  { name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ] },
  //  { name: 'paragraph',   groups: [ 'list', 'indent', 'blocks', 'align', 'bidi' ] },
  //  { name: 'styles' },
  //  { name: 'colors' }
  //];
  config.toolbar_standard = [
    //加粗     斜体，     下划线      穿过线      下标字        上标字
    ['Bold','Italic','Underline','Strike','Subscript','Superscript'],
    // 数字列表          实体列表            减小缩进    增大缩进
    ['NumberedList','BulletedList','-','Outdent','Indent'],
    //左对 齐             居中对齐          右对齐          两端对齐
    ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
    //超链接  取消超链接 锚点
    ['Link','Unlink','Anchor'],
    //图片    flash    表格       水平线            表情       特殊字符        分页符
    ['Image','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak'],
    // 样式       格式      字体    字体大小
    //['Styles','Format','Font','FontSize'],
    ['Styles','Format','FontSize'],
    //文本颜色     背景颜色
    ['TextColor','BGColor'],
    //全屏           显示区块
    ['Maximize', 'ShowBlocks','-']
  ];

  config.toolbar_mini = [
    ["Bold",  "Italic",  "Underline",  "Strike",  "Format"],
  ];
  //config.toolbar = "mini";
  config.extraPlugins = 'image,smiley';
  // ... rest of the original config.js  ...
}
