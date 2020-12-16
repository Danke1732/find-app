if (document.URL.match( /articles[/]\d+/ )) {
  function like() {
    const bookmarkBtn = document.querySelector('.bookmarks-btn');
    const articleMark = document.querySelector('.article-marks');
    if (bookmarkBtn.getAttribute('data-load') != null) {
      return null;
    }
    bookmarkBtn.setAttribute('data-load', 'true');
    bookmarkBtn.addEventListener('click', () => {
      const articleId = bookmarkBtn.getAttribute('data-num');
      const XHR = new XMLHttpRequest();
      XHR.open('POST', `/bookmarks/${articleId}`, true);
      XHR.responseType = 'json';
      XHR.send();
      XHR.onload = () => {
        if (XHR.status !== 200) {
          alert(`Error ${XHR.status}: ${XHR.statusText}`);
          return null;
        }
        const bookmarksAfter = XHR.response.bookmark;
        let check = XHR.response.registration;
        if (bookmarksAfter != null) {
          bookmarkBtn.setAttribute('data-check', 'true');
          articleMark.setAttribute('data-status', 'true')
          articleMark.innerHTML = `ブックマーク登録を${check}`;
        } else if (bookmarksAfter == null) {
          bookmarkBtn.removeAttribute('data-check');
          articleMark.setAttribute('data-status', 'false')
          articleMark.innerHTML = `ブックマーク登録を${check}`;
        }
      }
    });
  };
  setInterval(like, 1000);
}