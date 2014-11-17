@import url(//fonts.googleapis.com/css?family=Droid+Sans);
@import url(//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css);
body { font-family: "Droid Sans", sans-serif; font-weight: 300; font-size: 10px; color: <%foreground%>; background: <%background%>; }
form img, input, form, button, .code { border: dashed 1px <%foreground%>; border-radius: 7px; float: left; display: block; margin: 5px; }
form { margin: 0; }
img:hover, input:hover, input:focus, #retry:hover { border: solid 1px <%foreground%>;}
form img { width: 400px; height: 60px; }
input, button { background: <%background%>; color: <%foreground%>; outline: none; }
input { margin-top: 0px; padding: 4px; clear: both; width: 356px; font-size: 16px; height: 20px; }
button::-moz-focus-inner { border: 0; }
button { width: 30px; height: 30px; margin-top: 0px; margin-left: 0px; transition: transform 0.3s ease-in-out;}
button:before { font-family: "FontAwesome"; font-size: 20px; content: "\f021"; }
button:hover { transform: rotate(180deg); }