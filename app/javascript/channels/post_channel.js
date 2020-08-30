import consumer from "./consumer"

consumer.subscriptions.create("PostChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("connected")
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    //current_user_id is set in application.html.erb
    var user_ids = data.user_ids
    if (user_ids.includes(Number(current_user_id))) {
      $('#post-container').prepend(data.content);
      // prepend "new post" div with link to top of page if it does not exist
      var body = document.getElementsByTagName("body")[0];
      if (document.getElementById("post-notification") == null) {
        var notice = document.createElement("div");
        notice.id = "post-notification";
        notice.classList.add("bg-primary", "row", "position-fixed", "justify-content-center", "pb-2");
        notice.style.color = "white"
        notice.innerHTML = '<strong>New Posts</strong>';
        body.prepend(notice);
      }
      //smooth scroll to top and remove notice
      $("#post-notification").click(function() {
        $("html, body").animate({ scrollTop: 0 }, "slow");
        $("#post-notification").remove();
        return false;
      });
    }
  }
});
