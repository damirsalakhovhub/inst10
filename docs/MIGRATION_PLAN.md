# План миграции на стиль 37signals (Fizzy)

## Этап 1: Аутентификация (замена Devise)

### Шаг 1: Current объект ✅
- [x] Создать `app/models/current.rb` для хранения текущего пользователя/сессии

### Шаг 2: Модель Session
- [ ] Создать миграцию для таблицы `sessions`
- [ ] Создать модель `app/models/session.rb`
- [ ] Связать Session с User

### Шаг 3: Замена Devise на has_secure_password
- [ ] Создать миграцию для замены Devise полей:
  - Удалить: `encrypted_password`, `reset_password_token`, `reset_password_sent_at`, `remember_created_at`
  - Добавить: `password_digest` (string)
- [ ] Обновить модель User:
  - Удалить `devise`
  - Добавить `has_secure_password`
  - Добавить валидации для email

### Шаг 4: Authentication concern
- [ ] Создать `app/controllers/concerns/authentication.rb`
- [ ] Реализовать методы:
  - `authenticated?` - проверка авторизации
  - `require_authentication` - before_action для защиты
  - `resume_session` - восстановление сессии из cookie
  - `start_new_session_for(user)` - создание новой сессии
  - `terminate_session` - выход

### Шаг 5: SessionsController
- [ ] Создать `app/controllers/sessions_controller.rb`
- [ ] Реализовать `new`, `create`, `destroy`
- [ ] Использовать email + password для входа

### Шаг 6: Обновление ApplicationController
- [ ] Включить Authentication concern
- [ ] Удалить Devise методы
- [ ] Использовать Current.user вместо current_user

### Шаг 7: Обновление views
- [ ] Обновить `app/views/landing/index.html.erb` - форма входа
- [ ] Обновить `app/views/shared/_header.html.erb` - использовать Current.user
- [ ] Удалить все Devise views

### Шаг 8: Обновление routes
- [ ] Удалить `devise_for :users`
- [ ] Добавить `resource :session, only: [:new, :create, :destroy]`
- [ ] Обновить пути для регистрации (если нужна)

### Шаг 9: Удаление Devise
- [ ] Удалить `app/controllers/users/sessions_controller.rb`
- [ ] Удалить `app/controllers/users/registrations_controller.rb`
- [ ] Удалить `app/views/devise/`
- [ ] Удалить `config/initializers/devise.rb`
- [ ] Удалить гем `devise` из Gemfile

## Этап 2: Тестирование (RSpec → Minitest)

### Шаг 1: Настройка Minitest
- [ ] Удалить RSpec из Gemfile
- [ ] Убедиться что Minitest включен (по умолчанию в Rails)
- [ ] Создать `test/test_helper.rb`
- [ ] Настроить fixtures

### Шаг 2: Миграция тестов
- [ ] Переписать `spec/models/user_spec.rb` → `test/models/user_test.rb`
- [ ] Переписать `spec/requests/users_spec.rb` → `test/controllers/sessions_controller_test.rb`
- [ ] Переписать `spec/system/landing_page_spec.rb` → `test/system/landing_page_test.rb`
- [ ] Переписать `spec/system/projects_spec.rb` → `test/system/projects_test.rb`

### Шаг 3: Замена Factory Bot на Fixtures
- [ ] Создать `test/fixtures/users.yml`
- [ ] Создать `test/fixtures/projects.yml`
- [ ] Удалить `spec/factories/`
- [ ] Удалить гем `factory_bot_rails` из Gemfile

### Шаг 4: Добавление Mocha
- [ ] Добавить `mocha` в Gemfile (group :test)
- [ ] Настроить в `test/test_helper.rb`

## Этап 3: Очистка зависимостей

### Шаг 1: Удаление ненужных гемов
- [ ] Удалить `pagy` → заменить на `geared_pagination`
- [ ] Удалить `paper_trail`
- [ ] Удалить `avo` (admin панель)
- [ ] Удалить `bullet` (performance monitoring)
- [ ] Удалить `annotate` (model annotations)
- [ ] Удалить `hotwire-livereload` (live reload)

### Шаг 2: Замена Pagy на geared_pagination
- [ ] Добавить `geared_pagination` в Gemfile
- [ ] Обновить контроллеры для использования geared_pagination
- [ ] Обновить views для пагинации

## Этап 4: Финальная проверка

- [ ] Все тесты проходят
- [ ] Аутентификация работает
- [ ] Нет упоминаний Devise в коде
- [ ] Нет упоминаний RSpec в коде
- [ ] Все использует Current.user
- [ ] Fixtures работают корректно

