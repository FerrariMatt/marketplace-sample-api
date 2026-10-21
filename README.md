# Sample Marketplace API

> API de exemplo de marketplace construída com Ruby on Rails — projeto de estudo para aprender na prática a estruturação de APIs em Rails e boas práticas de desenvolvimento.

**Stack atual:**

| Componente | Versão / Detalhe |
|---|---|
| Ruby | `3.4.10` |
| Rails | `8.1.4` |
| Banco de dados | PostgreSQL (`pg ~> 1.1`) |
| Servidor web | Puma |

---

## Sobre o projeto

O objetivo deste repositório é evoluir, passo a passo, uma API REST de marketplace fictício — com produtos, vendedores, compras e pedidos — para estudar e praticar o desenvolvimento de uma API em Ruby on Rails

## Requisitos

- Ruby (versão compatível com Rails 8.1 — ver `.ruby-version` / `ruby` no `Gemfile.lock`)
- PostgreSQL rodando localmente (ex.: `sudo service postgresql start` ou Docker)
- Bundler (`gem install bundler`)

## Como rodar

```bash
# 1. Clone o repositório
git clone <url-do-repo> sample-marketplace-api
cd sample-marketplace-api

# 2. Instale as dependências
bundle install

# 3. Crie as configurações
cp config/database.yml.example config/database.yml 2>/dev/null || true
cp .env.example .env

# 4. Crie e migre o banco de dados
rails db:prepare

# 5. Suba o servidor
bin/rails server
```

A aplicação estará disponível em `http://localhost:3000`.

## Como rodar os testes

```bash
bin/rails test
```

## Qualidade de código

```bash
bundle exec rubocop     # Lint (estilo Rails omakase)
bundle exec brakeman     # Auditoria de segurança
bundle exec bundler-audit check
```

## Modelagem do banco de dados

![Database schema](https://dbdiagram.io/d/databate-marketplace-sample-api-6ad828f9f8963ca19c6ab0e2)

> Diagrama interativo disponível em: [dbdiagram.io](https://dbdiagram.io/d/databate-marketplace-sample-api-6ad828f9f8963ca19c6ab0e2)

### Endpoints (rascunho)

| Método | Rota | Descrição |
|---|---|---|
| `POST` | `/api/v1/auth/register` | Registro de usuário |
| `POST` | `/api/v1/auth/login` | Login, retorna token |
| `GET` | `/api/v1/products` | Lista produtos (pagination, filtros) |
| `GET` | `/api/v1/products/:id` | Detalhe de um produto |
| `POST` | `/api/v1/products` | Cria produto (seller autenticado) |
| `PATCH` | `/api/v1/products/:id` | Atualiza produto |
| `DELETE` | `/api/v1/products/:id` | Remove produto |
| `POST` | `/api/v1/orders` | Cria pedido |
| `GET` | `/api/v1/orders` | Lista pedidos do usuário |
| `PATCH` | `/api/v1/orders/:id/status` | Atualiza status do pedido |

### Convenções de resposta

- Sucesso: `200/201` com payload em JSON;
- Erros: `4xx/5xx` com `{ "errors": [ ... ] }`;
- Pagination: `page` / `per_page` + meta (`total`, `current_page`, `total_pages`);
- Versionamento: prefixo `/api/v1`.
