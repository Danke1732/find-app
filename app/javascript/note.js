function note() {
  const memoArea = document.getElementById('memo-field');
  const memoSubmit = document.querySelector('.memo-submit');
  memoSubmit.addEventListener('click', (e) => {
    e.preventDefault();
    const formData = new FormData(document.querySelector('.memo-form'));
    const XHR = new XMLHttpRequest();
    XHR.open('POST', '/notes', true);
    XHR.responseType = 'json';
    XHR.send(formData);
    XHR.onload = () => {
      if (XHR.status != 200) {
        alert(`Error ${XHR.status}: ${XHR.statusText}`);
        return null;
      }
      const errorElement = document.getElementById('memo-error');
      if (errorElement) {
        errorElement.remove();
      }
      const errorMessage = XHR.response.error_message;
      if (errorMessage) {
        const userSupport = document.querySelector('.user-support-menu');
        const error = `<li class="error-message" id="memo-error">${errorMessage}</li>`;
        userSupport.insertAdjacentHTML('beforeend', error);
        return null;
      }
      const saveNote = XHR.response.note;
      const saveDate = XHR.response.date;
      const noteBox = document.querySelector('.note-box');
      if (noteBox != null) {
        const html = `<div class="note-content">
        <p>${saveNote.text}</p>
        <p>${saveDate}</p>
        <div class="note-delete fas fa-trash-alt" data-num="${saveNote.id}"></div>
        </div>`;
        noteBox.insertAdjacentHTML('afterbegin', html);
      }
      memoArea.value = '';
    }
  });
}
window.addEventListener('DOMContentLoaded', note);