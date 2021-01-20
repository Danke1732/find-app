function responsiveNote() {
  const responsiveMemoArea = document.getElementById('responsive_memo_field');
  const responsiveMemoSubmit = document.querySelector('.responsive_memo_submit');
  
  responsiveMemoSubmit.addEventListener('click', (e) => {
    e.preventDefault();
    const formData = new FormData(document.querySelector('.responsive_memo_form'));
    const XHR = new XMLHttpRequest();
    XHR.open('POST', '/notes', true);
    XHR.responseType = 'json';
    XHR.send(formData);
    XHR.onload = () => {
      if (XHR.status != 200) {
        alert(`Error ${XHR.status}: ${XHR.statusText}`);
        return null;
      }
      const responsiveErrorElement = document.getElementById('responsive_memo_error');
      if (responsiveErrorElement) {
        responsiveErrorElement.remove();
      }
      const responsiveErrorMessage = XHR.response.error_message;
      if (responsiveErrorMessage) {
        const responsiveNote = document.querySelector('.responsive_note');
        const error = `<li class="error-message" id="responsive_memo_error">${responsiveErrorMessage}</li>`;
        responsiveNote.insertAdjacentHTML('afterend', error);
        return null;
      }
      const responsiveSaveNote = XHR.response.note;
      const responsiveSaveDate = XHR.response.date;
      const responsiveNoteBox = document.querySelector('.note-box');
      if (responsiveNoteBox != null) {
        const html = `<div class="note-content">
        <p>${responsiveSaveNote.text}</p>
        <p>${responsiveSaveDate}</p>
        <div class="note-delete fas fa-trash-alt" data-num="${responsiveSaveNote.id}"></div>
        </div>`;
        responsiveNoteBox.insertAdjacentHTML('afterbegin', html);
      }
      responsiveMemoArea.value = '';
    }
  });
}
window.addEventListener('DOMContentLoaded', responsiveNote);