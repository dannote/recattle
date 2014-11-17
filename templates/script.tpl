var form = document.querySelector('form');
var image = form.querySelector('img');
var input = form.querySelector('input');
function update() {
  image.src = image.src.split('#')[0] + '#' + Date.now();
  input.value = '';
  input.focus();
}
image.addEventListener('click', update);
form.querySelector('button').addEventListener('click', update);
function notify() {
  update();
  document.location.hash = 'retry';
  setTimeout(function () {
    document.location.hash = 'please';
  }, 2000);
}