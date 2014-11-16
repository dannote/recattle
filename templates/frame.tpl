<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <style>
      @import url(//fonts.googleapis.com/css?family=Open+Sans);
      @import url(//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css);
      body { margin: 0; font-family: "Open Sans", sans-serif; font-weight: 300; font-size: 10px; color: <%foreground%>; background: <%background%>; }
      img, input, form, button { border: dashed 1px <%foreground%>; border-radius: 7px; float: left; display: block; margin: 5px; }
      form { margin: 0; }
      img:hover, input:hover, input:focus, #retry:hover { border: solid 1px <%foreground%>;}
      img { width: 400px; height: 60px; }
      input, button { background: <%background%>; color: <%foreground%>; outline: none; }
      input { margin-top: 0px; padding: 4px; clear: both; width: 356px; font-size: 16px; height: 20px; }
      button::-moz-focus-inner { border: 0; }
      button { width: 30px; height: 30px; margin-top: 0px; margin-left: 0px; transition: transform 0.3s ease-in-out;}
      button:before { font-family: "FontAwesome"; font-size: 20px; content: "\f021"; }
      button:hover { transform: rotate(180deg); }
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
      <? for i = 1, 3 do ?>
      // hahahaha
      <? end ?>
      <? if 1 == 1 then ?>
      true
      <? else ?>
      false
      <? end ?>
    </script>
  </body>
</html>