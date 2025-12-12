ТЕХНИЧЕСКОЕ ЗАДАНИЕ: Input Component

Цель: Создать базовый компонент текстового поля с чистой архитектурой, accessibility и системой токенов, аналогично Button Component.

Структура файлов:
app/components/input/
  - input_component.rb          Ruby класс компонента
  - input_component.html.erb    HTML шаблон
  - input_component.scss        Главный файл, импортирует части
  - _input_tokens.scss          Токены компонента (размеры, цвета)
  - _input_base.scss            Базовые стили инпута
  - _input_sizes.scss           Размеры (medium по умолчанию)
  - _input_states.scss          Состояния (:focus, :disabled, :hover)

Параметры компонента (input_component.rb):
- label: (String) - текст лейбла над инпутом
- name: (String, required) - атрибут name для формы
- id: (String, optional) - если не передан, генерируется автоматически из name
- placeholder: (String, optional) - текст плейсхолдера
- required: (Boolean, default: false) - показывает красную звездочку, добавляет HTML-атрибут required
- icon: (String/Symbol, optional) - имя SVG-иконки слева (без "-icon.svg")
- size: (Symbol, default: :medium) - размер инпута (:medium для первой итерации)
- type: (String, default: "text") - тип инпута (text, email, password и т.д.)
- value: (String, optional) - начальное значение
- disabled: (Boolean, default: false) - отключенное состояние
- **options - дополнительные HTML-атрибуты (class, data-*, aria-*)

HTML структура (input_component.html.erb):
<div class="input-wrapper">
  <label class="input-label" for="<id>">
    <span class="input-label-text"><label_text></span>
    <span class="input-label-required" aria-hidden="true">*</span> <!-- если required -->
  </label>
  
  <div class="input-container">
    <span class="input-icon" aria-hidden="true"><!-- SVG --></span> <!-- если icon -->
    <input class="input" ... />
  </div>
</div>

SCSS токены (_input_tokens.scss):
Использовать существующие core (--px-*) и semantic (--color-*, --font-*, --radius-*) токены:

--input-medium--font-size: var(--font-size-m);
--input-medium--line-height: var(--px-24);
--input-medium--padding-inline: var(--px-12);
--input-medium--padding-block: var(--px-8);
--input-medium--icon-size: var(--px-20);
--input-medium--icon-gap: var(--px-8);

--input--bg: var(--color-bg-base);
--input--border-color: var(--color-bg-cuatro);
--input--border-color-hover: var(--color-bg-cinco);
--input--border-color-focus: var(--color-link-uno);
--input--text-color: var(--color-font-uno);
--input--placeholder-color: var(--color-font-cuatro);
--input--label-color: var(--color-font-dos);
--input--required-color: var(--color-danger);
--input--border-radius: var(--radius-xs);

Accessibility требования:
1. <label> обязателен, связан с <input> через for/id
2. Звездочка aria-hidden="true" (декоративная, required атрибут достаточен)
3. Иконка слева aria-hidden="true" (декоративная)
4. :focus-visible для фокуса клавиатурой
5. disabled атрибут для отключенного состояния
6. Плейсхолдер не заменяет лейбл
7. autocomplete атрибут для автозаполнения браузером (username, email, current-password, new-password и т.д.)
8. Инпуты должны быть обернуты в <form> для корректной работы автозаполнения браузером

Состояния (_input_states.scss):
- :hover - изменение цвета границы
- :focus - выделенная граница (--input--border-color-focus)
- :disabled - приглушенные цвета, cursor: not-allowed
- :placeholder - стилизация плейсхолдера

Вывод в UI Kit (app/views/ui_kit/pages/inputs.html.erb):
Аналогично buttons.html.erb:
- Секция "Default" с примерами medium размера
- Варианты: без иконки, с иконкой, required, disabled
- Примеры с разными type (text, email, password)

Маршрут: Уже существует get "inputs", to: "pages#inputs" в routes.rb

Первая итерация:
- Только размер medium
- Декоративная иконка слева
- Красная звездочка для required
- Базовые состояния (hover, focus, disabled)
- Один вариант - default

Будущие итерации:
- Дополнительные размеры (tiny, small, large, xlarge)
- Кликаемая иконка справа
- Состояния ошибки/успеха
- Вспомогательный текст (hint)
- Сообщения об ошибках

