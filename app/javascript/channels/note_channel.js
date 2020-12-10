import consumer from "./consumer"

consumer.subscriptions.create("NoteChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    const html = `<p class="note-content">${data.content.text}</p>`;
    const note = document.querySelector('.memo-area');
    const noteBox = document.querySelector('.note-box');
    const noteSubmit = document.querySelector('.memo-submit');
    noteSubmit.disabled = false;
    noteBox.insertAdjacentHTML('afterbegin', html);
    note.value = '';
  }
});
