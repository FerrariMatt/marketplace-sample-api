# Contexto do projeto

> Fatos estáveis sobre o projeto. Lido logo após o `CLAUDE.md`.
> Ordem de leitura: `CLAUDE.md` → `contexto.md` → `decisoes.md` → `plano.md`.

## O que é
- API REST de um marketplace fictício (produtos, vendedores, compras e pedidos), evoluída passo a passo.

## Por que existe / problema que resolve
- Projeto de **estudo**: primeiro passo da trilha de estudo de Rails do Ferrari (aprender a estruturar APIs em Rails com boas práticas).
- **O Ferrari escreve o código à mão.** O Claude Code revisa, tira dúvidas e auxilia; não implementa features por conta própria sem ele pedir.

## Stack
- Linguagem / framework: Ruby 3.4.13, Rails 8.1 (API-only), Puma
- Banco: PostgreSQL
- Auth: Devise
- Testes: RSpec, FactoryBot, FFaker, shoulda-matchers, SimpleCov, rswag (Swagger em `/api-docs`)
- Qualidade: RuboCop (omakase), Brakeman, bundler-audit
- Infra / ambiente: WSL (Ubuntu) com rbenv; deploy previsto com Kamal + Thruster
- CI: GitHub Actions (`.github/workflows/ci.yml`) em todo PR e push na `main`: Brakeman + bundler-audit, RuboCop e RSpec com Postgres 18.

## Como rodar
```bash
# de dentro do WSL, no diretório do projeto
bin/setup                          # bundle install + db:prepare
bin/dev                            # servidor em http://api.lvh.me:3000
bundle exec rspec spec lib/spec    # testes
```

## Restrições e premissas
- Testes com **100% de cobertura**; o CI é a fonte primária de validação de cada PR.
- Rotas no subdomínio `api`, sem prefixo `/api`; versionamento pelo header `Accept` (detalhes no `CLAUDE.md`).

## Links
- Hub no KB: `F:\Knowledge Base\02 Dev\Projetos\Sample marketplace API.md`
- Remoto: https://github.com/FerrariMatt/marketplace-sample-api
