// .tweetBox textareaに移動してフォーカスする
var moveToTweetBox = function(){
  $('html,body').animate({ scrollTop: $("#header").offset().top }, 'slow','swing');
  var tweetBox = $(".tweetBox textarea");
  window.setTimeout(function(){ tweetBox.focus(); }, 1000);
};

// ReplyとRTボタンをクリックした時の挙動を設定する
var clickRetweetAndReply = function(){
  $(".tweet").each(function(){
    var tweetBox = $(".tweetBox textarea");
    var text = $(this).find(".body").text();
    var user = $(this).find(".user a").text();
    $(this).find(".buttons .retweet").live("click", function(){
      tweetBox.text("RT @" + user + " " + text);
      moveToTweetBox();
      tweetBox.get(0).setSelectionRange(0, 0);
    });
    $(this).find(".reply").click(function(){
      tweetBox.text("@" + user + " ");
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
  $(".tweetBox textarea").keydown(function(event){
    if (event.keyCode != "219") {
      return;
    }
    var self = this;
    $(this).autocomplete("/user/names")
      .result(function(event, item){
        $(self).val($(self).val() + " ");
        $(self).unbind();
      });
  });
};

$(function(){
  focusTweetBox();
  countUpTweetBox();
  clickRetweetAndReply();
  lazyload();
  autoCompleteName();
});

