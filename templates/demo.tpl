<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>recattle - search query based Turing test</title>
    <style>
      <% require "templates.style.frame" %>
      <% require "templates.style.index" %>
    </style>
  </head>
  <body>
    <header>
      <h1>recattle</h1>
      <div>Тест Тьюринга на основе реальных поисковых запросов в Яндексе</div>
    </header>
    <iframe src="/frame?callback=/validate" frameborder="0" width="414" height="109" scrolling="no" seamless="seamless"></iframe>
  </body>
</html>