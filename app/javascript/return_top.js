function returnTop() {
  const returnBtn = document.querySelector('.return_top_btn');

  window.addEventListener('scroll', () => {
    if (800 < window.scrollY) {
      returnBtn.classList.remove('hidden');
    } else {
      returnBtn.classList.add('hidden');
    }
  });
}
window.addEventListener('DOMContentLoaded', returnTop);