Dev Mode Setup

Запуск (одна команда):

```
bin/dev   # поднимает Rails на PORT=7000, CSS без sass
```

Ключевые настройки:

- `Procfile.dev`: только `web: PORT=7000 bin/rails server`
- CSS лежит в `app/assets/stylesheets`, без SCSS и sass-watch
- `config/environments/development.rb`: hotwire_livereload слушает `app/assets/stylesheets`
- Кэш отключён в dev (`public_file_server` no-store)

Если застряло:

```
bin/rails tmp:cache:clear
rm -rf public/assets
```

Запрещено:

- `bin/rails assets:precompile` в dev (ломает live обновление)

