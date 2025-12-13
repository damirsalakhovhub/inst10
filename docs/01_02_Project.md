Project Management

Acceptance criteria
- Юзер может создать проект с названием и описанием.
- Юзер видит список своих проектов.
- Юзер может отредактировать свой проект.
- Юзер не может видеть/редактировать чужие проекты.

Jobs to be done

1. Project Model
   ✅ Миграция с полями: name, description, user_id, created_at, updated_at
   ✅ Связь belongs_to user
   ✅ Связь has_many tasks, dependent: destroy
   ✅ Валидация presence для name
   ✅ Тесты для модели (валидации, ассоциации)

2. CRUD Operations
   ✅ Создание проекта с owner
   ✅ Редактирование name/description
   ⏸️ Удаление проекта (каскадное удаление задач)
   ✅ Список проектов текущего юзера

3. Authorization
   ✅ Pundit политика: только owner может редактировать/удалять проект
   ✅ Только owner видит проект и его задачи (policy scope, show/update)
   ✅ Редирект или 403 при попытке доступа к чужому проекту

4. Routes
   ✅ GET /projects - список проектов юзера
   ✅ GET /projects/:id - просмотр проекта
   ✅ POST /projects - создание проекта
   ✅ PATCH /projects/:id - редактирование
   ⏸️ DELETE /projects/:id - удаление

5. UI
   ✅ Список проектов с кнопкой "Create Project" (Projects#index, New Project link)
   ✅ Форма создания/редактирования проекта (new/edit + form partial)
   ◽️ Карточка проекта со списком задач внутри
   ⏸️ Кнопки Edit/Delete на карточке проекта

