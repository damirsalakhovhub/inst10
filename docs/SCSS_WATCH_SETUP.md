# Настройка Watch-режима для SCSS с немедленным отображением изменений

## Проблема
Изменения в SCSS токенах (особенно в импортируемых файлах) не видны в браузере после обновления страницы.

## Причины
1. **Sass watch** может не отслеживать изменения в импортируемых файлах без флага `--poll`
2. **Propshaft** кэширует digests файлов (application-4af18c7c.css)
3. **Браузер** кэширует CSS файлы

## Решение

### 1. Настроить правильный путь импорта в application.scss

```scss
// ❌ Неправильно
@import '../components/ui/button_component';

// ✅ Правильно (с --load-path=app)
@import 'components/ui/button_component';
```

### 2. Добавить timestamp в layout для development

**Файл:** `app/views/layouts/application.html.erb`

```erb
<%# In development, add timestamp to bust browser cache for immediate CSS updates %>
<% if Rails.env.development? %>
  <%= stylesheet_link_tag "application?v=#{File.mtime(Rails.root.join('app/assets/builds/application.css')).to_i}", "data-turbo-track": "reload" %>
<% else %>
  <%= stylesheet_link_tag "application", "data-turbo-track": "reload" %>
<% end %>
```

### 3. Отключить asset digest в development

**Файл:** `config/environments/development.rb`

```ruby
# Serve assets in development
config.assets.server = true

# Disable asset digests in development so CSS changes are immediately visible
config.assets.digest = false

# Disable caching for assets in development
config.public_file_server.headers = { 
  "Cache-Control" => "no-cache, no-store, must-revalidate, max-age=0",
  "Pragma" => "no-cache",
  "Expires" => "0"
}
```

### 4. Создать initializer для Propshaft (опционально, если digest=false не работает)

**Файл:** `config/initializers/propshaft.rb`

```ruby
# In development, serve CSS directly without digests for immediate updates
if Rails.env.development?
  # Simply disable asset digest in development
  Rails.application.config.assets.digest = false
end
```

### 5. Запустить Sass watch с правильными параметрами

```bash
# В одном терминале: Sass watch
sass --watch --poll --load-path=app --no-source-map \
  app/assets/stylesheets/application.scss:app/assets/builds/application.css

# В другом терминале: Rails server
bin/rails server -p 3000
```

### Или использовать bin/dev с обновленным Procfile.dev

**Файл:** `Procfile.dev`

```
web: bin/rails server -p 3000
css: sass --watch --poll --load-path=app --no-source-map app/assets/stylesheets/application.scss:app/assets/builds/application.css
```

Затем запустить:
```bash
bin/dev
```

## Ключевые флаги для Sass

- `--watch` — отслеживает изменения в файлах
- `--poll` — **критически важно** для отслеживания изменений в импортируемых файлах (@import)
- `--load-path=app` — позволяет импортировать из `components/ui/...` вместо `../components/ui/...`
- `--no-source-map` — не генерирует source maps (не обязательно, но ускоряет)

## Проверка работоспособности

1. Измени значение в `app/components/ui/_button_tokens.scss`:
   ```scss
   --btn-large-padding-block: 999px;
   ```

2. Подожди 3-4 секунды (пока Sass пересоберет CSS)

3. Обнови страницу в браузере (F5 или Cmd+R)

4. Проверь, что изменения видны

## Быстрая диагностика

```bash
# Проверить, что Sass watch запущен
ps aux | grep sass

# Проверить timestamp файла CSS
ls -lh app/assets/builds/application.css

# Проверить значение токена в скомпилированном CSS
grep "btn-large-padding-block" app/assets/builds/application.css

# Проверить URL CSS в HTML
curl -s http://localhost:3000/kit/buttons | grep stylesheet

# Проверить содержимое CSS от сервера
curl -s http://localhost:3000/assets/application.css | grep "btn-large-padding-block"
```

## Важно

- **Без флага `--poll`** Sass может не отслеживать изменения в импортируемых файлах
- **Timestamp в layout** обеспечивает, что браузер всегда запрашивает актуальную версию CSS
- **Изменения видны через 3-4 секунды** после сохранения файла (время на компиляцию Sass)

