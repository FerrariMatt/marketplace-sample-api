# Sample Marketplace API

> API de exemplo de marketplace construída com Ruby on Rails: projeto de estudo para aprender na prática a estruturar APIs em Rails e seguir boas práticas de desenvolvimento.

**Stack atual:**

| Componente | Versão / Detalhe |
|---|---|
| Ruby | `3.4.13` (ver `.ruby-version`) |
| Rails | `8.1.4.1` (modo API-only) |
| Banco de dados | PostgreSQL (`pg 1.7`) |
| Servidor web | Puma `8.1` |
| Autenticação | Devise `5.0.4` |
| Testes | RSpec (`rspec-rails 8.1`), FactoryBot, FFaker, shoulda-matchers, SimpleCov |
| Documentação da API | rswag (Swagger / OpenAPI) |
| Jobs, cache e cable | Solid Queue, Solid Cache, Solid Cable |
| Deploy | Kamal + Thruster |

---

## Sobre o projeto

O objetivo deste repositório é evoluir, passo a passo, uma API REST de um marketplace fictício (produtos, vendedores, compras e pedidos) para estudar e praticar o desenvolvimento de APIs em Ruby on Rails.

**Status:** em construção. Hoje existe o model `User` com Devise e a estrutura de roteamento versionado; os endpoints abaixo ainda são um rascunho.

## Requisitos

- Ruby `3.4.13` (o projeto usa rbenv; a versão é lida de `.ruby-version`)
- PostgreSQL rodando localmente (ex.: `sudo service postgresql start` ou Docker)
- Bundler (`gem install bundler`)

## Como rodar

```bash
# 1. Clone o repositório
git clone git@github.com:FerrariMatt/marketplace-sample-api.git sample-marketplace-api
cd sample-marketplace-api

# 2. Instale as dependências, prepare o banco e suba o servidor
bin/setup
# (ou passo a passo: bundle install && bin/rails db:prepare && bin/dev)
```

O `config/database.yml` aponta para um PostgreSQL em `localhost:5432`. Ajuste usuário e senha para o seu ambiente, ou defina `DATABASE_URL`, que sobrescreve o arquivo.

A aplicação sobe em `http://localhost:3000`. As rotas da API ficam no subdomínio `api`, então use **`http://api.lvh.me:3000`** (o `lvh.me` resolve para `127.0.0.1`).

## Rotas e versionamento

- A API responde no subdomínio `api` e **não** tem prefixo `/api` no path (ex.: `http://api.lvh.me:3000/products`).
- A versão é escolhida pelo header `Accept`: `application/vnd.marketplace.v1`. Sem o header, vale a versão padrão (v1). A lógica está em `lib/api_constraints.rb`.
- Os controllers ficam em `app/controllers/api/v1/`.

## Documentação da API (Swagger)

A interface do Swagger fica em `http://localhost:3000/api-docs`. A documentação é gerada a partir dos specs do rswag: todo endpoint deve ter um spec rswag.

```bash
bundle exec rake rswag:specs:swaggerize   # gera swagger/v1/swagger.yaml
```

## Como rodar os testes

O projeto usa **RSpec** (Minitest está desativado).

```bash
bundle exec rspec spec lib/spec
```

> `lib/spec/` fica fora do padrão do RSpec e precisa ser passado explicitamente. O relatório de cobertura (SimpleCov) é gerado em `coverage/index.html`.

## Qualidade de código

```bash
bin/rubocop                       # Lint (estilo Rails omakase)
bin/brakeman --no-pager           # Auditoria de segurança do código
bin/bundler-audit                 # Vulnerabilidades conhecidas nas gems
bin/ci                            # Roda setup, lint e auditorias de uma vez
```

## CI

O GitHub Actions (`.github/workflows/ci.yml`) roda em todo pull request e em push na `main`:

- `scan_ruby`: Brakeman e bundler-audit
- `lint`: RuboCop
- `test`: RSpec contra um PostgreSQL de serviço

O Dependabot mantém gems e actions atualizadas.

## Modelagem do banco de dados

> Diagrama interativo disponível em: [dbdiagram.io](https://dbdiagram.io/d/databate-marketplace-sample-api-6ad828f9f8963ca19c6ab0e2)

### Endpoints (rascunho)

| Método | Rota | Descrição |
|---|---|---|
| `POST` | `/auth/register` | Registro de usuário |
| `POST` | `/auth/login` | Login, retorna token |
| `GET` | `/products` | Lista produtos (paginação, filtros) |
| `GET` | `/products/:id` | Detalhe de um produto |
| `POST` | `/products` | Cria produto (vendedor autenticado) |
| `PATCH` | `/products/:id` | Atualiza produto |
| `DELETE` | `/products/:id` | Remove produto |
| `POST` | `/orders` | Cria pedido |
| `GET` | `/orders` | Lista pedidos do usuário |
| `PATCH` | `/orders/:id/status` | Atualiza status do pedido |

> Todas as rotas ficam em `api.<host>` e a versão vai no header `Accept`.

### Convenções de resposta

- Sucesso: `200/201` com payload em JSON;
- Erros: `4xx/5xx` com `{ "errors": [ ... ] }`;
- Paginação: `page` / `per_page` + `meta` (`total`, `current_page`, `total_pages`);
- Versionamento: header `Accept: application/vnd.marketplace.v1`.
