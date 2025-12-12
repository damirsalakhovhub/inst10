ТЕХНИЧЕСКОЕ ЗАДАНИЕ: Dialog Component

Цель: Создать базовый компонент диалогового окна с чистой архитектурой, полной accessibility и системой токенов.

ТРЕБОВАНИЯ К МИНИМАЛЬНОЙ ВЕРСИИ:

Визуал:
- Фон-оверлей (backdrop) с полупрозрачностью
- Диалоговое окно по центру экрана
- Скругленные углы
- Тень для глубины
- Минимальная ширина и высота
- Заголовок
- Текстовый контент
- Кнопка закрытия (X)

Структура файлов:
app/components/dialog/
  - dialog_component.rb          Ruby класс компонента
  - dialog_component.html.erb    HTML шаблон
  - dialog_component.scss        Главный файл, импортирует части
  - _dialog_tokens.scss          Токены компонента
  - _dialog_base.scss            Базовые стили
  - _dialog_states.scss          Состояния (open, closing)

Параметры компонента (dialog_component.rb):
- title: (String, required) - заголовок диалога
- content: (String, optional) - текстовый контент или блок через yield
- open: (Boolean, default: false) - открыто ли окно
- id: (String, optional) - уникальный ID
- **options - дополнительные атрибуты

HTML структура (native dialog element):
<dialog id="dialog-id" role="dialog" aria-labelledby="dialog-title" aria-modal="true">
  <div class="dialog-container">
    <div class="dialog-header">
      <h2 id="dialog-title" class="dialog-title">Title</h2>
      <button type="button" class="dialog-close" aria-label="Close dialog">
        <span aria-hidden="true">×</span>
      </button>
    </div>
    <div class="dialog-content">
      Content here or yield block
    </div>
  </div>
</dialog>
<div class="dialog-backdrop" aria-hidden="true"></div>

SCSS токены (_dialog_tokens.scss):
Использовать core (--px-*) и semantic (--color-*, --radius-*) токены:

--dialog--min-width: var(--px-320);
--dialog--max-width: var(--px-600);
--dialog--min-height: var(--px-200);
--dialog--padding: var(--px-24);
--dialog--gap: var(--px-16);

--dialog--bg: var(--color-bg-base);
--dialog--border-radius: var(--radius-m);
--dialog--shadow: 0 var(--px-20) var(--px-60) rgba(0, 0, 0, 0.3);

--dialog--backdrop-bg: rgba(0, 0, 0, 0.5);

--dialog--title-font-size: var(--font-size-xl);
--dialog--title-line-height: var(--px-32);
--dialog--title-font-weight: var(--font-semibold);
--dialog--title-color: var(--color-font-uno);

--dialog--content-font-size: var(--font-size-m);
--dialog--content-line-height: var(--px-24);
--dialog--content-color: var(--color-font-dos);

--dialog--close-size: var(--px-32);
--dialog--close-icon-size: var(--px-24);

ACCESSIBILITY ТРЕБОВАНИЯ (КРИТИЧНО):

1. Нативный <dialog> element:
   - Использовать нативный HTML5 <dialog>
   - Автоматический focus trap
   - Встроенная поддержка ESC для закрытия
   - Автоматический aria-modal="true"

2. ARIA атрибуты:
   - role="dialog" (обязателен)
   - aria-labelledby связан с заголовком
   - aria-describedby для контента (опционально)
   - aria-modal="true" (диалог блокирует взаимодействие с фоном)
   - aria-label="Close dialog" на кнопке закрытия

3. Focus Management:
   - При открытии фокус переходит на первый интерактивный элемент или на сам диалог
   - Focus trap - фокус не выходит за пределы диалога
   - При закрытии фокус возвращается на элемент, который открыл диалог
   - Visible focus indicators

4. Keyboard Navigation:
   - ESC закрывает диалог
   - TAB и Shift+TAB циклично перемещаются внутри диалога
   - Enter/Space активируют кнопки

5. Backdrop (оверлей):
   - aria-hidden="true" (не доступен для скринридеров)
   - Клик по backdrop закрывает диалог (опционально)
   - pointer-events: none на контенте под диалогом

6. Inert attribute:
   - Контент за диалогом становится inert (недоступен)
   - Нативный <dialog> делает это автоматически

7. Screen readers:
   - Анонс открытия диалога
   - Чтение заголовка и описания
   - Информирование о закрытии

JavaScript функциональность (Stimulus controller):
app/javascript/controllers/dialog_controller.js:
- open() - открытие диалога (dialog.showModal())
- close() - закрытие диалога (dialog.close())
- handleEscape() - обработка ESC
- handleBackdropClick() - закрытие по клику на backdrop
- trapFocus() - управление фокусом внутри диалога
- restoreFocus() - возврат фокуса после закрытия

ЭТАПЫ РЕАЛИЗАЦИИ:

ЭТАП 1: Базовая структура
- Создать dialog_component.rb с минимальными параметрами (title, content)
- Создать HTML шаблон с нативным <dialog>
- Базовая разметка: header, content, close button
- Без стилей, только семантика

ЭТАП 2: Базовые токены
- Создать _dialog_tokens.scss
- Определить размеры (min/max width, padding, gap)
- Определить цвета (bg, text, backdrop)
- Определить тень и border-radius

ЭТАП 3: Базовые стили
- Создать _dialog_base.scss
- Стилизация backdrop (оверлей)
- Центрирование диалога
- Стили для header, title, close button
- Стили для content
- Тень и скругление углов

ЭТАП 4: Состояния и анимации
- Создать _dialog_states.scss
- Анимация появления (fade + scale)
- Анимация закрытия
- Поддержка prefers-reduced-motion
- Состояние :modal (когда открыт через showModal())

ЭТАП 5: Accessibility - базовая
- Добавить все ARIA атрибуты
- role="dialog"
- aria-labelledby связь с заголовком
- aria-modal="true"
- aria-label на кнопке закрытия

ЭТАП 6: JavaScript controller (Stimulus)
- Создать dialog_controller.js
- Реализовать open() через dialog.showModal()
- Реализовать close() через dialog.close()
- Обработка ESC (нативная в dialog)
- Обработка клика по backdrop

ЭТАП 7: Focus management
- Focus trap (нативный в dialog)
- Автофокус на первый интерактивный элемент
- Возврат фокуса после закрытия
- Visible focus indicators

ЭТАП 8: Интеграция в UI Kit
- Создать страницу ui_kit/pages/dialogs.html.erb
- Примеры разных типов диалогов
- Кнопки для открытия
- Демонстрация всех состояний

ЭТАП 9: Расширенная функциональность
- Поддержка форм внутри диалога
- Размеры (small, medium, large)
- Позиционирование (center, top, bottom)
- Варианты (default, alert, confirm)

ЭТАП 10: Тестирование accessibility
- Тестирование клавиатурой (без мыши)
- Проверка screen reader (VoiceOver/NVDA)
- Проверка focus trap
- Проверка ESC и backdrop
- Проверка возврата фокуса

КЛЮЧЕВЫЕ ОСОБЕННОСТИ:

1. Использование нативного <dialog>:
   - Браузерная поддержка focus trap
   - Встроенный ESC handler
   - Автоматический backdrop
   - Правильная семантика
   - Inert на фоновом контенте

2. Минимальный JavaScript:
   - Только open/close логика
   - Нативные возможности браузера
   - Stimulus для связывания с UI

3. Progressive enhancement:
   - Работает без JS (fallback на visibility)
   - Полная функциональность с JS
   - Graceful degradation

4. Темная тема:
   - Автоматическая поддержка через semantic tokens
   - --color-bg-base, --color-font-* автоматически меняются

БУДУЩИЕ УЛУЧШЕНИЯ:

- Draggable диалоги
- Resizable диалоги
- Stacking (несколько диалогов)
- Полноэкранный режим
- Диалоги с формами (интеграция с Input Component)
- Confirm/Alert варианты с кнопками действий
- Toast notifications на базе диалогов
- Drawer (боковые панели)

ВАЖНО:
- Начинаем с самого базового - статичный диалог с заголовком и текстом
- Каждый этап должен работать независимо
- Тестируем accessibility после каждого этапа
- Не добавляем функциональность без необходимости (YAGNI)
- Фокус на нативных возможностях браузера

