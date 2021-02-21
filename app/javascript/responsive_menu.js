function responsiveAction() {
  const menuIcon = document.querySelector('.menu-icon');
  const menuBox = document.querySelector('.responsive-menu-area');
  const mask = document.getElementById('mask');
  const closeMenu = document.querySelector('.menu-close');

  menuIcon.addEventListener('click', () => {
    menuBox.classList.toggle('visible');
    mask.classList.toggle('visible');
  });

  closeMenu.addEventListener('click', () => {
    menuBox.classList.remove('visible');
    mask.classList.remove('visible');
  });

  mask.addEventListener('click', () => {
    closeMenu.click();
  });
};
addEventListener('DOMContentLoaded', responsiveAction);