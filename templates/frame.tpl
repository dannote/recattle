<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <style>
      <%= require "templates.style" %>
      body { margin: 0; }
    </style>
  </head>
  <body>
    <form method="<%method%>" action="<%callback%>">
      <%= require "templates.form" %>
    </form>
    <script>
      <%= require "templates.script" %>
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