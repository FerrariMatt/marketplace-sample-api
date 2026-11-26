# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

Rails 8.1 API-only app (Ruby 3.4.13, PostgreSQL, Devise, RSpec, rswag). Study project for a marketplace API.

Read next: `.context/contexto.md` → `.context/decisoes.md` → `.context/plano.md`. Ferrari writes the code by hand; Claude reviews and assists.

## Running commands

- Ruby comes from **rbenv inside WSL** and only loads in an interactive bash. From Windows, always run:
  `wsl -d Ubuntu -- bash -ic "cd '/home/ferrari-dev/Projetos/Ruby on Rails/sample-marketplace-api' && <command>"`
  (A plain `bash -lc` or the Windows `bundle` on PATH picks up the wrong Ruby.)
- Tests are **RSpec**, not Minitest (test_unit railtie is disabled; README's `bin/rails test` is wrong):
  `bundle exec rspec spec lib/spec` — `lib/spec/` is outside the default pattern and must be passed explicitly.
- Lint/security (same as `bin/ci`): `bin/rubocop`, `bin/bundler-audit`, `bin/brakeman --quiet --no-pager --exit-on-warn --exit-on-error`. GitHub CI (`.github/workflows/ci.yml`) runs these plus the RSpec suite against Postgres on every PR and push to `main`; it is the primary validation gate for a PR. Still run specs locally before pushing.

## API conventions

- Routes live under `namespace :api` with `constraints: { subdomain: "api" }` and `path: "/"` — URLs have no `/api` prefix, and request specs must use an `api.` host (e.g. `host! "api.lvh.me"`).
- Versioning is via `ApiConstraints` (`lib/api_constraints.rb`): `Accept: application/vnd.marketplace.v1`; v1 is the default. Controllers go in `app/controllers/api/v1/`.
- Every endpoint gets an **rswag spec**, which doubles as the docs served at `/api-docs`.
- Responses: JSON; errors as `{ "errors": [...] }`; pagination via `page`/`per_page` + `meta` (`total`, `current_page`, `total_pages`).
- Generators are set to RSpec + FactoryBot (`spec/factories`); use FFaker for fake data and shoulda-matchers in model specs.
- API token strategy for login is **not decided yet** — ask before adding devise-jwt or any token gem.

## Git

- `bin/*` and `.kamal/hooks/*` often show as modified only due to file-mode changes (755→644, from editing via `\\wsl.localhost`). Never stage or commit these mode-only changes.
- PRs follow `.github/pull_request_template.md`.
