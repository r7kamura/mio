// Ajax update in Rails 3

var bindRemote = function(selector) {
  $(selector)
    .click(function(){
      $(this).hide();
      $('<img src="/images/loading.gif" class="loading"/>').insertAfter($(this));
    });
  $(selector)
    .bind("ajax:success", function(evt, data, status, xhr){
      $(this)
        .replaceWith(data)
        .fadeIn();
      bindRemote(selector);
      $(".loading").fadeOut();
    });
  $('.images a').lightBox();
};
