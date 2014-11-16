<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>recattle - search query based Turing test</title>
    <style>
      <% require "templates.style" %>
      body, header { margin: 5px; }
      header h1 { font-size: 32px; font-style: bold; margin-top: 0px; margin-bottom: 0px; }
      header div { font-style: italic; font-size: 10px; padding-top: 3px; border-top: dashed 1px black; width: 414px; }
      #retry:target:hover { transform: none; }
      #retry:target:before { content: "\f00d"; }
    </style>
  </head>
  <body>
    <header>
      <h1>recattle</h1>
      <div>Тест Тьюринга на основе реальных поисковых запросов в Яндексе</div>
    </header>
    <form action="/validate">
      <img src="challenge.png?background=white&amp;foreground=black"/>
      <input name="response" type="text" autocomplete="off"/ >
      <button type="button" id="retry"></button>
    </form>
    <script>
      var form = document.querySelector('form');
      var image = form.querySelector('form img');
      var input = form.querySelector('[name=response]');
      
      function update() {
        image.src = image.src.split('#')[0] + '#' + Date.now();
        input.value = '';
        input.focus();
      }

      function notify() {
        update();
        document.location.hash = 'retry';
        setTimeout(function () {
          document.location.hash = 'please';
        }, 2000);
      }

      image.addEventListener('click', update);
      form.querySelector('#retry').addEventListener('click', update);
      form.addEventListener('submit', function (event) {
        event.preventDefault();
        if (!input.value.length) {
          notify();
          return false;
        } 
        var request = new XMLHttpRequest();
        request.addEventListener('load', function () {
          if (!JSON.parse(request.responseText)) {
            notify();
          } else {
            alert('Все верно');
            update();
          }
        });
        request.open('POST', form.action);
        request.send('response=' + input.value);
        return false;
      });
    </script>
  </body>
</html>