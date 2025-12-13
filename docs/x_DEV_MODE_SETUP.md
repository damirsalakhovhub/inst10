Dev Mode Setup

Запуск в двух терминалах:

bundle exec sass --watch --poll --load-path=app --load-path=ui_kit --load-path=app/views --no-source-map app/assets/stylesheets/application.scss:app/assets/builds/application.css
PORT=3000 bin/rails server

После первого запуска или изменения конфигов:

rm -rf public/assets/.manifest.json tmp/cache/*

Ключевые настройки:

Procfile.dev - два процесса (web и css)
config/initializers/assets.rb - load-path для app, ui_kit, app/views
config/environments/development.rb - hotwire_livereload слушает app/assets/builds, отключен кэш
config/application.rb - autoload_paths и eager_load_paths для ui_kit/components
config/initializers/view_component.rb - предзагрузка компонентов

Работа:

Изменяешь SCSS → Sass пересобирает через 2-3 сек → Hotwire LiveReload обновляет браузер автоматически

