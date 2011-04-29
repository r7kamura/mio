$(function(){
  // focus tweet-box
  var tweetBox = $(".tweetBox textarea");
  tweetBox.focus();

  // countup tweet-box
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

  // RT & Reply
  var moveToTweetBox = function(){
    $('html,body').animate({ scrollTop: $("#header").offset().top }, 'slow','swing');
    window.setTimeout(function(){ tweetBox.focus(); }, 1000);
  };
  $(".tweet").each(function(){
    var text = $(this).find(".body").text();
    var user = $(this).find(".user a").text();
    $(this).find(".retweet").click(function(){
      tweetBox.text("RT @" + user + " " + text);
      moveToTweetBox();
    });
    $(this).find(".reply").click(function(){
      tweetBox.text("@" + user + " ");
      moveToTweetBox();
    });
  });

});

