<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <style>
      <% require "templates.style" %>
      body { margin: 0; }
    </style>
  </head>
  <body>
    <form method="<%method%>" action="<%callback%>">
      <img src="challenge?background=<%background%>&amp;foreground=<%foreground%>"/>
      <input name="response" autocomplete="off" />
      <button type="button"></button>
    </form>
    <script>
      var form = document.querySelector("form");
      var image = form.querySelector("img");
      var input = form.querySelector("input");
      function update() {
        image.src = image.src.split("#")[0] + "#" + Date.now();
        input.value = "";
        input.focus();
      }
      image.addEventListener("click", update);
      form.querySelector("button").addEventListener("click", update);
      form.addEventListener("submit", function (event) {
        var cookie = document.cookie.match(/recattle=([^;]+)/);
        if (cookie) {
          var input = document.createElement("input");
          input.setAttribute("name", "challenge");
          input.setAttribute("value", cookie[1]);
          input.setAttribute("type", "hidden");
          form.appendChild(input);
        }
      });
    </script>
  </body>
</html>