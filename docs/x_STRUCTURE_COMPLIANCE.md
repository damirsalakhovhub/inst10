Соответствие структуры проекта принципам Fizzy

Статус: Частично соответствует

Соответствует

1. Структура папок app/
   ✅ models/ с подпапкой concerns/
   ✅ controllers/ с подпапкой concerns/
   ✅ views/ организованы по ресурсам (users/, home/, landing/)
   ✅ policies/ - Pundit политики есть
   ✅ views/shared/ - переиспользуемые partials
   ✅ jobs/ - фоновые задачи
   ✅ mailers/ - почтовые шаблоны
   ✅ javascript/controllers/ - Stimulus контроллеры

2. Models
   ✅ Каждая модель в отдельном файле
   ✅ Папка concerns/ существует
   ✅ Scopes используются (User имеет scopes)
   ✅ Валидации в модели (Devise в User)

3. Policies
   ✅ ApplicationPolicy базовый класс
   ✅ UserPolicy существует
   ✅ Методы show?, create?, update?, destroy? определены

4. Views
   ✅ Организация по ресурсам (users/, home/)
   ✅ Layouts в views/layouts/
   ✅ Shared части в views/shared/

5. Тесты
   ✅ spec/models/ - тесты моделей
   ✅ spec/requests/ - тесты контроллеров
   ✅ spec/policies/ - тесты политик
   ✅ spec/factories/ - FactoryBot фабрики

Не соответствует / Нужно добавить

1. Current объект
   ❌ Нет Current.user паттерна
   ❌ Используется current_user из Devise вместо Current.user
   ❌ Нет установки Current в ApplicationController
   Действие: Добавить Current объект и before_action в ApplicationController

2. Models
   ❌ Нет моделей Project и Task
   ❌ Нет concerns для моделей (Accessible, Filterable, Publishable)
   Действие: Создать модели и concerns по мере необходимости

3. Controllers
   ❌ Нет ProjectsController и TasksController
   ❌ Нет concerns для контроллеров (Authorization, FilterScoped)
   ❌ Нет before_action для установки ресурсов
   Действие: Создать контроллеры и concerns при реализации

4. Views
   ❌ Нет views/projects/ и views/tasks/
   Действие: Создать при реализации функционала

5. Routes
   ❌ Нет RESTful routes для projects и tasks
   Действие: Добавить при создании контроллеров

Что нужно сделать сейчас

1. Добавить Current объект
   - Создать app/models/current.rb
   - Добавить before_action в ApplicationController для установки Current.user
   - Использовать Current.user вместо current_user в моделях для дефолтных значений

2. При создании Project и Task
   - Использовать Current.user для belongs_to :user, default: -> { Current.user }
   - Создавать concerns только когда логика переиспользуется
   - Использовать before_action :set_project, :set_task в контроллерах

3. При создании контроллеров
   - Создавать concerns только для общей логики
   - Использовать before_action для проверки прав через Pundit
   - Использовать respond_to если нужен json

Вывод

Базовая структура соответствует принципам. Основные отличия:
- Нет Current.user паттерна (используется Devise current_user)
- Нет моделей и контроллеров для Project/Task (еще не реализовано)

Рекомендация: Добавить Current объект сейчас, остальное создавать по мере реализации функционала согласно принципам.

