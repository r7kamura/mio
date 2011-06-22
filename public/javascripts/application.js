// .tweetBox textareaに移動してフォーカスする
var moveToTweetBox = function(){
  $('html,body').animate({ scrollTop: $("#header").offset().top }, 'slow','swing');
  var tweetBox = $(".tweetBox textarea");
  window.setTimeout(function(){ tweetBox.focus(); }, 1000);
};

// ReplyとRTボタンをクリックした時の挙動を設定する
var clickRetweetAndReply = function(){
  var tweetBox = $(".tweetBox textarea");
  $(".tweet").each(function(){
    var text = $(this).find(".body").text();
    var user = $(this).find(".user a").text();
    $(this).find(".buttons .retweet").live("click", function(){
      tweetBox.val("RT @" + user + " " + text);
      moveToTweetBox();
      tweetBox.get(0).setSelectionRange(0, 0);
    });
    $(this).find(".reply").live("click", function(){
      tweetBox.val("@" + user + " ");
      moveToTweetBox();
      var textLength = tweetBox.text().length;
      tweetBox.get(0).setSelectionRange(textLength, textLength);
    });
  });
};

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
      success: function(html){
        $(".tweets ul").prepend(html);
        clickRetweetAndReply();
      }
    });
  }, interval);
};

// countup tweet-box
var countUpTweetBox = function(){
  $(".tweetBox textarea").keyup(function(){
    var counter = $(this).val().length;
    $("#countUp").text(counter);
    if (counter == 0) {
      $("#countUp").text("0");
    } else if (counter >= 140) {
      $("#countUp").css("color","red");
    } else {
      $("#countUp").css("color","#666");
    }
  });
};

// つぶやくフォームにフォーカスする
var focusTweetBox = function(){
  $(".tweetBox textarea").focus();
};


// 画像を遅延読込みする
var lazyload = function(){
  $("img").lazyload({ placeholder : "/images/grey.gif" });
};

// ユーザ名を補完する
var autoCompleteName = function(){
  $(".tweetBox textarea").keyup(function(event){
    if ($(this).hasClass("completable") || $(".tweetBox textarea").val()[0] != "@") {
      return;
    }
    $(this).addClass("completable");
    var self = this;
    $(this).autocomplete("/user/names")
      .result(function(event, item){
        $(self).val($(self).val() + " ");
        $(self).unbind();
      });
    $(this).keydown();
  });
};

// simple link_to_remote
var bindToggleCalendar = function(){
  $(".gadgets .calendar").live("ajax:success", function(data, status, xhr){
    var link = $(this);
    $("#" + link.attr("data-update")).hide().html(status).slideDown("slow");
    $("#gadget .close").click(function(){
      $("#gadget").slideUp("slow");
    });
  });
};

var bindTweetBox = function(){
  $(".tweetBox form").live("ajax:success", function(data, status, xhr){
    $(this).find("textarea").val("");
  });
};

var initPusher = function(key){
  var pusher  = new Pusher(key);
  var channel = pusher.subscribe("tweet");
  channel.bind("tweet-created", function(data) {
    if ($(location).attr("href").match("/search")) return;

    $(".tweets ul").prepend(data);
    clickRetweetAndReply();
    focusTweetBox();
  });
};


$(function(){
  focusTweetBox();
  countUpTweetBox();
  clickRetweetAndReply();
  lazyload();
  autoCompleteName();
  bindToggleCalendar();
  bindTweetBox();
});
