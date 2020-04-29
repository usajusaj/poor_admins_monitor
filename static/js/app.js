// Side menu js adapted from pure demo

const layout = document.getElementById('layout'),
    menu = document.getElementById('menu'),
    menuLink = document.getElementById('menuLink'),
    content = document.getElementById('main');

function toggleAll(e) {
    e.preventDefault();
    layout.classList.toggle('active')
    menu.classList.toggle('active')
    menuLink.classList.toggle('active')
}

menuLink.addEventListener('click', toggleAll);
content.addEventListener('click', e => {
    if (menu.classList.contains('active')) {
        toggleAll(e);
    }
});
