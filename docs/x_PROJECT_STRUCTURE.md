Project Structure Principles (based on Fizzy)

Общие принципы организации кода

1. Структура папок app/
   - models/ - модели с concerns в подпапке concerns/
   - controllers/ - контроллеры с concerns в подпапке concerns/
   - views/ - views организованы по ресурсам (projects/, tasks/, users/)
   - policies/ - Pundit политики, одна на ресурс
   - components/ - ViewComponent компоненты (если используем)
   - jobs/ - фоновые задачи
   - mailers/ - почтовые шаблоны
   - helpers/ - минимально, только если действительно нужно
   - javascript/ - Stimulus контроллеры в controllers/

2. Models
   - Каждая модель в отдельном файле
   - Общая логика выносится в concerns/ (Accessible, Filterable, Publishable и т.д.)
   - Concerns именуются по функциональности, не по модели
   - Используем Current.user для дефолтных значений belongs_to
   - Scopes для частых запросов
   - Валидации в модели, не в контроллере

3. Controllers
   - Один контроллер на ресурс (ProjectsController, TasksController)
   - Общая логика в concerns/ (Authorization, FilterScoped, BoardScoped)
   - before_action для установки ресурса (@project, @task)
   - before_action для проверки прав доступа
   - respond_to для html/json если нужно
   - Используем Current.user вместо current_user где возможно

4. Policies (Pundit)
   - Одна политика на ресурс (ProjectPolicy, TaskPolicy)
   - Наследуемся от ApplicationPolicy
   - Методы show?, create?, update?, destroy?
   - Scope методы для фильтрации списков

5. Views
   - Организация по ресурсам: views/projects/, views/tasks/
   - Частичные шаблоны с префиксом _ (например _form.html.erb)
   - Layouts в views/layouts/
   - Shared части в views/shared/ или views/application/

6. Concerns
   - Модели: app/models/concerns/ - переиспользуемая логика моделей
   - Контроллеры: app/controllers/concerns/ - общая логика контроллеров
   - Именование по функциональности: Accessible, Filterable, Publishable
   - Не создаем concerns для одной модели/контроллера

7. Current объект
   - Используем Current.user вместо передачи через параметры
   - Current.account если нужна мультитенантность
   - Устанавливается в ApplicationController через before_action

8. Naming conventions
   - Модели: Project, Task, User (единственное число, PascalCase)
   - Контроллеры: ProjectsController, TasksController (множественное число)
   - Политики: ProjectPolicy, TaskPolicy (единственное число)
   - Views папки: projects/, tasks/ (множественное число)
   - Concerns: Accessible, Filterable (прилагательные/причастия)

9. Routes
   - RESTful по умолчанию
   - Вложенные ресурсы для зависимых сущностей (tasks в project)
   - Member routes для действий над конкретным ресурсом
   - Collection routes для действий над коллекцией

10. Миграции
    - Одна миграция на одну логическую задачу
    - Именование: create_projects, add_user_id_to_tasks
    - Индексы для внешних ключей и частых запросов
    - Не используем change, пишем up/down явно

11. Тесты
    - spec/models/ - тесты моделей
    - spec/controllers/ или spec/requests/ - тесты контроллеров
    - spec/policies/ - тесты политик
    - spec/factories/ - FactoryBot фабрики
    - Один файл теста на один класс

12. Общие правила
    - YAGNI - не создаем структуру заранее, только когда нужно
    - DRY - выносим общее в concerns, helpers, shared views
    - KISS - простая структура, без лишних абстракций
    - Один файл - одна ответственность
    - Fat models, skinny controllers - бизнес-логика в моделях

