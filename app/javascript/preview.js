if (document.URL.match( /articles[/]new/ ) || document.URL.match( /articles/ ) || document.URL.match( /articles[/]\d+[/]edit/ ) || document.URL.match( /articles[/]\d+/ )) {
  window.addEventListener('DOMContentLoaded', () => {
    const imageList = document.getElementById('image-content');

    document.getElementById('image').addEventListener('change', (e) => {
      const imageBefore = document.querySelector('.review-image');
      if (imageBefore) {
        imageBefore.remove();
      }

      function createImageHTML() {
        const imageDisplay = document.createElement('div');
        const image = document.createElement('img');
        image.setAttribute('src', blob);
        image.setAttribute('class', 'review-image');
        imageDisplay.appendChild(image);
        imageList.appendChild(imageDisplay);
      }

      const file = e.target.files[0];
      const blob = window.URL.createObjectURL(file);
      createImageHTML(blob);
    });
  });
}