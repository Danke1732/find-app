if (document.URL.match(/users[/]\d+[/]notes/)) {
  function noteDelete() {
    let noteDeletes = document.querySelectorAll('.note-delete');
    for(let i = 0; i < noteDeletes.length; i++) {
      noteDeletes[i].addEventListener('click', (e) => {
        if (noteDeletes[i].getAttribute('data-load') != null) {
          return null;
        }
        noteDeletes[i].setAttribute('data-load', 'true');
        const noteId = e.target.dataset.num
        const XHR = new XMLHttpRequest();
        XHR.open('DELETE', `/notes/${noteId}`, true);
        XHR.responseType = 'json';
        XHR.send();
        XHR.onload = () => {
          if (XHR.status != 200) {
            alert(`Error ${XHR.status}: ${XHR.statusText}`);
            return null;
          }
          const deleteNote = XHR.response.note;
          if (deleteNote == null) {
            noteDeletes[i].parentNode.remove();
          } 
        }
      });
    }
  }
  setInterval(noteDelete, 1000);
}