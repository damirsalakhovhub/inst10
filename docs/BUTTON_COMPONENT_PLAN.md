# План создания универсального компонента кнопки

## Принципы проектирования

### 1. Универсальность
- Компонент должен работать в любом контексте приложения
- Не зависит от родительских стилей (изолирован)
- Использует дизайн-токены вместо хардкода значений

### 2. Accessibility First
- Полная поддержка клавиатурной навигации
- Корректные ARIA атрибуты
- Поддержка screen readers
- Фокус-индикаторы
- Правильная семантика HTML

### 3. Готовность к переводам
- Все текстовые значения через i18n
- Поддержка RTL языков (на будущее)
- Плейсхолдеры для динамического контента

### 4. Композиция и расширяемость
- Модульная структура (базовый компонент + варианты)
- Легко расширяется новыми типами и размерами
- Следует принципу DRY

## Структура компонента

### Технологический стек
- **ViewComponent** - для создания переиспользуемого компонента
- **SCSS** - стили с использованием дизайн-токенов
- **Stimulus** (опционально) - для интерактивности (loading state, etc.)
- **i18n** - для переводов

### Файловая структура
```
app/components/
  button_component.rb          # Основной компонент
  button_component.html.erb    # HTML шаблон
  button_component.scss        # Стили компонента
app/assets/stylesheets/
  components/
    _button.scss               # Стили кнопки (если нужны глобальные)
```

## Параметры компонента

### Обязательные параметры
- `text` (String) - текст кнопки (переводимый через i18n)

### Опциональные параметры

#### Тип кнопки (`variant`)
- `primary` (по умолчанию)
- `secondary` - вторичная кнопка
- `success` - успешное действие
- `danger` - опасное действие
- `warning` - предупреждение
- `info` - информационная
- `ghost` - прозрачная/призрачная
- `link` - кнопка в виде ссылки

#### Размер (`size`)

- `tiny` (xs)
- `small` (s)
- `medium` (m) - по умолчанию
- `large` (l)
- `xlarge` (xl)


#### Скругленность (`rounded`)
- `small` - небольшое скругление (по умолчанию)
- `medium` - среднее скругление
- `large` - большое скругление
- `full` - полностью скругленная (pill)

#### Иконка (`icon`)
- `nil` (по умолчанию) - без иконки
- `String` - имя иконки (SVG или Heroicons)
- `Hash` - `{ name: "icon_name", position: :left }` или `:right`

#### Режим иконки (`icon_mode`)
- `:with_text` (по умолчанию) - иконка + текст
- `:icon_only` - только иконка (требует `aria-label`)

#### Состояния (`state`)
- `:default` - обычное состояние
- `:loading` - загрузка (с индикатором)
- `:disabled` - отключена
- `:active` - активна (для toggle кнопок)

#### Дополнительные параметры
- `type` - HTML type (`button`, `submit`, `reset`)
- `href` - если указан, рендерится как `<a>`, иначе `<button>`
- `method` - HTTP метод для ссылок (PUT, DELETE, etc.)
- `data` - Hash для data-атрибутов
- `aria` - Hash для ARIA атрибутов
- `class` - дополнительные CSS классы
- `id` - HTML id атрибут
- `title` - HTML title (для tooltip)
- `block` - Boolean, полная ширина блока

## Accessibility требования

### ARIA атрибуты
- `aria-label` - обязателен для icon-only кнопок
- `aria-busy="true"` - для loading состояния
- `aria-disabled="true"` - для disabled состояния
- `aria-pressed` - для toggle кнопок
- `aria-describedby` - для дополнительного описания

### Клавиатура
- `Enter` и `Space` активируют кнопку
- Видимый focus indicator (outline)
- Tab order корректный
- Disabled кнопки не получают фокус

### Screen readers
- Корректная семантика (`<button>` vs `<a>`)
- Описательные labels
- Состояния объявляются (loading, disabled)

## Стилизация

### Использование дизайн-токенов
- Цвета из `_colors.scss`
- Размеры из `_sizes.scss`
- Типографика из `_typography.scss`
- CSS custom properties для динамических значений

### Структура классов (BEM-like)
```scss
.button {
  &--variant-primary { }
  &--variant-secondary { }
  &--size-small { }
  &--size-medium { }
  &--size-large { }
  &--rounded-none { }
  &--rounded-small { }
  &--state-loading { }
  &--state-disabled { }
  &--icon-only { }
  &--block { }
  
  &__icon {
    &--left { }
    &--right { }
  }
  
  &__spinner { }
}
```

## i18n структура

### Локализация текста
```yaml
en:
  components:
    button:
      submit: "Submit"
      cancel: "Cancel"
      delete: "Delete"
      edit: "Edit"
      save: "Save"
      loading: "Loading..."
```

### Использование в компоненте
```ruby
text = t("components.button.#{key}", default: text)
```

## Примеры использования

### Базовое использование
```erb
<%= render ButtonComponent.new(text: "Submit") %>
```

### С иконкой слева
```erb
<%= render ButtonComponent.new(
  text: "Save",
  icon: "check",
  icon_position: :left
) %>
```

### Только иконка
```erb
<%= render ButtonComponent.new(
  icon: "trash",
  icon_mode: :icon_only,
  aria: { label: "Delete item" }
) %>
```

### Loading состояние
```erb
<%= render ButtonComponent.new(
  text: "Processing",
  state: :loading
) %>
```

### Как ссылка
```erb
<%= render ButtonComponent.new(
  text: "Learn more",
  href: "/about",
  variant: :link
) %>
```

## План реализации

### Этап 1: Базовая структура
1. Создать ViewComponent с минимальным функционалом
2. Реализовать базовую HTML структуру
3. Добавить базовые стили используя токены

### Этап 2: Параметры и варианты
1. Реализовать все варианты (`variant`)
2. Реализовать размеры (`size`)
3. Реализовать скругленность (`rounded`)

### Этап 3: Иконки
1. Интеграция системы иконок (Heroicons или SVG)
2. Реализация позиционирования иконок
3. Режим icon-only

### Этап 4: Состояния
1. Loading состояние с индикатором
2. Disabled состояние
3. Active состояние (для toggle)

### Этап 5: Accessibility
1. ARIA атрибуты
2. Клавиатурная навигация
3. Screen reader тестирование
4. Focus indicators

### Этап 6: i18n
1. Структура переводов
2. Интеграция в компонент
3. Поддержка динамических значений

### Этап 7: Тестирование
1. Unit тесты компонента
2. Accessibility тесты (axe-core)
3. Визуальные тесты в UI Kit
4. Интеграционные тесты

### Этап 8: Документация
1. Документация в UI Kit
2. Примеры использования
3. Best practices

## Принципы именования

### Компонент
- `ButtonComponent` - полное имя класса
- `button_component` - файл и хелпер

### CSS классы
- BEM-like: `.button`, `.button--variant-primary`
- Префикс `button` для изоляции

### i18n ключи
- `components.button.{action}` - структура ключей
- Использование стандартных действий: submit, cancel, delete, etc.

## Best practices

1. **Всегда указывай aria-label для icon-only кнопок**
2. **Используй семантически правильный HTML** (`<button>` для действий, `<a>` для навигации)
3. **Не смешивай variant и size** - один вариант за раз
4. **Тестируй с клавиатуры** - убедись что все работает без мыши
5. **Используй токены** - не хардкодь значения
6. **Следуй принципу наименьшего удивления** - поведение должно быть предсказуемым

## Будущие улучшения

- Поддержка RTL языков
- Анимации переходов состояний
- Группы кнопок (button groups)
- Dropdown кнопки
- Split кнопки
- Поддержка темной темы (когда будет реализована)

