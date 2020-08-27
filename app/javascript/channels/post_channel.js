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
    }
  }
});
