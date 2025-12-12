RAILS TEMPLATE

Minimal Rails 8 template following 37signals philosophy.

---

STACK

Rails 8.0.4, Ruby 3.2.2, PostgreSQL

Core:
- Solid Queue/Cache/Cable (no Redis)
- Propshaft + Importmap (no build step)
- Hotwire (Turbo + Stimulus)
- ViewComponent

Auth:
- Devise (authentication)
- Pundit (authorization)

Features:
- Pagy (pagination)
- PaperTrail (audit trail)
- ActionText (rich text)
- ActiveStorage (file uploads)

Security:
- rack-attack (rate limiting)
- bundler-audit (vulnerability scanning)
- Brakeman (static analysis)

Testing:
- RSpec
- FactoryBot
- Capybara

Deploy:
- Kamal 2.0
- Thruster (HTTP/2 proxy)

---

SETUP

bin/setup
bin/dev

Tests: bundle exec rspec
Lint: bundle exec rubocop

---

ARCHITECTURE

Majestic Monolith
Convention over Configuration
YAGNI, KISS, DRY, SOLID

Server-rendered HTML with Hotwire for interactivity.
ViewComponent for reusable UI.
PostgreSQL for everything (data, cache, jobs, websockets).
