// 定期的につぶやきを更新して挿入する
var updateTweetsPeriodically = function(controller_name, query_name){
   // ページ指定がある場合は自動更新しない
  if ($(location).attr('href').match(/page/)) {
    return;
  }

  var interval = 60 * 1000;
  window.setInterval(function(){
    var id = $(".tweets li").get(0).id;
    $.ajax({
      url: "/tweet/update_remote",
      data: {
        id: id,
        controller_name: controller_name,
        query_name: query_name,
      },
      success: function(html){ $(".tweets ul").prepend(html).listview("refresh"); }
    });
  }, interval);
};
