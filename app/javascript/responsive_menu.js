function responsiveAction() {
  const menuIcon = document.querySelector('.menu-icon');
  const menuBox = document.querySelector('.responsive-menu-area');
  const closeMenu = document.querySelector('.menu-close');

  menuIcon.addEventListener('click', () => {
    menuBox.classList.toggle('visible');
  });

  closeMenu.addEventListener('click', () => {
    menuBox.classList.remove('visible');
  });
};

addEventListener('DOMContentLoaded', responsiveAction);