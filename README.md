recattle
========

Тест Тьюринга на основе реальных поисковых запросов в Яндексе

Примеры изображений
-------------------
![Пример #1](https://raw.githubusercontent.com/dannote/recattle/master/samples/1.png)

![Пример #2](https://raw.githubusercontent.com/dannote/recattle/master/samples/2.png)

![Пример #3](https://raw.githubusercontent.com/dannote/recattle/master/samples/3.png)

Встраивание
-----------
```html
<iframe src="http://recattle.dannote.net/frame?callback=[callback]&amp;method=[method]&amp;background=[background]&amp;foreground=[foreground]">
```

* `callback` &mdash; ссылка, по которой будет отправлен запрос с параметрами:
  - `response` &mdash; ответ от пользователя
  - `challenge` &mdash; идентификатор картинки
* `method` &mdash; метод, который будет использоваться при отправке запроса
* `background` &mdash; цвет заднего фона
* `foreground` &mdash; цвет текста и границ

API
---
`GET http://recattle.dannote.net/validate?challenge=[challenge]&response=[response]`
  &mdash; проверяет верность ответа, возвращает значение типа *boolean*