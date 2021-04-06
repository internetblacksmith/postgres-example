$(document).ready(
function() {
  $(".users").hover(
    function() {
      let user = $(this).attr("id");
      $(`.${user}`).addClass( "active" );
    },
    function() {
      let user = $(this).attr("id");
      $(`.${user}`).removeClass( "active" );
    }
  );
  $(".channels").hover(
    function() {
      let channel = $(this).attr("id");
      $(`.${channel}`).addClass( "active" );
    },
    function() {
      let channel = $(this).attr("id");
      $(`.${channel}`).removeClass( "active" );
    }
  );
})
