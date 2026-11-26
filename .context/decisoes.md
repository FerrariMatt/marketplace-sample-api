# Decisões do projeto

> Somente decisões **confirmadas pelo Ferrari**. Propostas do agente vão para `plano.md`.
> Mais recente no topo.

## 2026-11-26 — CI como barreira de validação
- **Contexto:** o CI começou só com lint e scan de segurança; depois ganhou o job de RSpec com Postgres.
- **Decisão:** o CI roda em todo PR e é a fonte primária de validação antes de subir um PR. Testes sempre com 100% de cobertura, garantida pelo `SimpleCov.minimum_coverage 100` em `spec/rails_helper.rb` (a suíte falha abaixo disso).
- **Motivo:** barreira extra de validação de código; vale para todos os projetos de código do Ferrari.

## 2026-11-26 — Código escrito à mão
- **Contexto:** projeto de estudo da trilha de Rails.
- **Decisão:** o Ferrari escreve o código à mão; o Claude Code revisa e auxilia.
- **Motivo:** aprender e revisar na prática.
