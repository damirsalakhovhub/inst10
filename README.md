# Rails Template

A production-ready Rails 8 foundation. Start building features, not infrastructure.

This template follows the majestic monolith philosophy: one database, one codebase, zero complexity. Everything you need, nothing you don't. YAGNI enforced.

## What You Get

**Authentication & Authorization** - Devise and Pundit, ready to use. User model with admin flag and audit trail.

**Background Jobs** - Solid Queue runs in your Puma process. No Redis, no Sidekiq, no separate workers. Scale when you need to.

**Caching** - Solid Cache uses PostgreSQL. No Redis cluster to manage. Good enough for most applications.

**File Uploads** - ActiveStorage with image processing. Rich text with ActionText. Works out of the box.

**Search** - pg_search uses PostgreSQL full-text search. No Elasticsearch needed.

**Security** - Comprehensive rate limiting (rack-attack), CSP, CORS, security scanning. Protected by default.

**Testing** - RSpec with examples. FactoryBot factories. Capybara for system tests. CI/CD configured.

**Deployment** - Kamal 2.0 for simple Docker deploys. Thruster for HTTP/2 proxy. One command deploys.

## Philosophy

PostgreSQL for everything. Database-backed jobs, cache, and WebSockets. One technology to master.

No build step. Propshaft for assets, Importmap for JavaScript. Modern browsers support ES modules natively.

Hotwire, not React. Server-rendered HTML with Turbo and Stimulus. Faster to build, easier to maintain.

Start simple, scale when needed. Solid Queue runs in Puma initially. Split to dedicated workers at 10K+ users. Add Redis at 100K+ if metrics justify it.

## Quick Start

```bash
# Clone
git clone git@github.com:damirsalakhovhub/rails-template.git your-project
cd your-project

# Configure (3 env vars)
cp .env.example .env
# Edit .env: APP_NAME, APP_NAME_SNAKE_CASE, APP_NAME_KEBAB_CASE

# Setup (installs dependencies, hooks, prepares database)
bin/setup --skip-server

# Optional: Enable AI code review
# Add to .env: OPENAI_API_KEY=your-key-here

# Run
bin/dev
```

Visit http://localhost:3000

## What's Included

Everything essential for a modern Rails app: authentication, authorization, jobs, cache, search, pagination, file uploads, rich text, security, testing, CI/CD, deployment.

No Redis, no build step, no frontend framework, no microservices. Just Rails.

## Production Ready

Before deploying, add:
- **Error tracking** - [docs/addons/error-tracking.md](docs/addons/error-tracking.md) (Sentry/Honeybadger)
- **Monitoring** - [docs/addons/monitoring.md](docs/addons/monitoring.md) (Prometheus)
- **Backups** - [docs/operations/backups.md](docs/operations/backups.md) (Database strategies)

All documented with complete guides.

## Optional Add-ons

GraphQL, Stripe, Redis, Analytics, and more. See `docs/addons/` for installation guides.

Add when you need them, not "just in case."

## Development

Direct-to-main workflow with automated checks. Pre-push hook runs tests and AI code review. GitHub Actions runs full CI suite.

No branches needed. No PRs required. Quality gates ensure safety.

## Documentation

- [Architecture](docs/ARCHITECTURE.md) - Technology choices and reasoning
- [Packages](docs/packages.md) - What's included and why
- [Quickstart](docs/QUICKSTART.md) - Step-by-step setup
- [AI Agent Guide](docs/ai-agent-guide.md) - Development patterns

## Tech Stack

- Ruby 3.2.2
- Rails 8.0.4
- PostgreSQL 15 (data, cache, jobs, WebSocket)
- Hotwire (Turbo + Stimulus)
- Kamal 2.0 (deployment)

## License

Private project
