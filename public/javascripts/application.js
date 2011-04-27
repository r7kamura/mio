$(function(){
     $("textarea").keyup(function(){
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
});

