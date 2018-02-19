// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require lightbox
//= require turbolinks
//= require_tree .

// Custom

document.addEventListener("turbolinks:load", function() {
  $(function() {
    $('span.instructions').click(function(event){
      event.preventDefault();
      $(this).next('small.section-description').toggle();
    });
  });

  $(function() {
    if ($('.pagination').length) {
      $(window).scroll(function() {
        var url;
        url = $('.pagination .next a').attr('href');
        if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 50)
         {
           $('.pagination').html("<div class='mx-auto'><img src='/preloader.gif'></div>");
           return $.getScript(url);
         }
      });
      return $(window).scroll();
    }
  });

  $(function() {
    if ($('.comment').length < 10) {
      $(".comment-reply-link.btn.btn-outline-primary.btn-lg").hide();
    } else {
      $(".comment-reply-link.btn.btn-outline-primary.btn-lg").eq(1).hide();
    }
  });
});

function replyToCommentable(commentable_id, commentable_type) {
  $(".comment-reply-link").show()
  $("#comment_commentable_type").val("" + commentable_type);
  $("#comment_commentable_id").val(commentable_id);
  $(this).hide();
  $(this).after($("#comment-reply-form"));
}
