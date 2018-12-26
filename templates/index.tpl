<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>recattle - search query based Turing test</title>
    <style>
      <%= require "templates.style" %>
      body { margin: 10px; }
      header { margin: 5px; }
      header h1 { font-size: 32px; font-style: bold; margin-top: 0px; margin-bottom: 0px; }
      header div { font-style: italic; font-size: 10px; padding-top: 3px; border-top: dashed 1px <%foreground%>; width: 414px; }
      #retry:target:hover { transform: none; }
      #retry:target:before { content: "\f00d"; }
    </style>
  </head>
  <body>
    <a href="https://github.com/dannote/recattle"><img style="position: absolute; top: 0; right: 0; border: 0;" src="https://camo.githubusercontent.com/38ef81f8aca64bb9a64448d0d70f1308ef5341ab/68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f6769746875622f726962626f6e732f666f726b6d655f72696768745f6461726b626c75655f3132313632312e706e67" alt="Fork me on GitHub" data-canonical-src="https://s3.amazonaws.com/github/ribbons/forkme_right_darkblue_121621.png"></a>
    <header>
      <h1>recattle</h1>
      <div>Тест Тьюринга на основе реальных поисковых запросов в Яндексе</div>
    </header>
    <form action="/validate">
      <%= require "templates.form" %>
    </form>
    <script>
      <%= require "templates.script" %>
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