# shopfront

Shopfront is an online store for a small bicycle-parts retailer. It lets customers
browse parts, build a cart and check out, and lets staff manage stock.

## Overview

The project is a multi-module repository. The backend is a Kotlin service built
with Gradle. The frontend is a TypeScript single-page app built with Vite. The two
talk over a REST API described by an OpenAPI spec.

The retailer has about 4,000 SKUs and ships to the Netherlands, Belgium and
Germany. Most traffic arrives in the evening, so the API is sized for peaks of
about 200 requests per second.

## Tech stack

- Kotlin 2.0 on JDK 21
- Spring Boot 3
- PostgreSQL 16
- TypeScript 5, Vite 5, React 18
- Docker for local development

## Repository layout

- `services/api/`: the Kotlin API
- `frontend/`: the web app
- `scripts/`: helper scripts
- `docs/`: documentation
- `infra/`: Terraform for the cloud environment

## Commands

- Build everything: `./gradlew build`
- Run the API tests: `./gradlew :services:api:test`
- Run one test class: `./gradlew :services:api:test --tests shop.CartServiceTest`
- Run the frontend tests: `cd frontend && npm test`
- Lint the frontend: `cd frontend && npm run lint`
- Start the frontend dev server: `cd frontend && npm run dev`
- Format Kotlin: `./gradlew ktlintFormat`
- Run end-to-end tests: `make e2e`

## Conventions

- Kotlin code follows the official Kotlin style guide.
- Prefer constructor injection over field injection.
- Write tests for every new endpoint.
- Keep functions short and focused.
- Use meaningful names for variables and functions.
- Write clean, readable code.
- Do not commit commented-out code.

## Rules

- Never edit files in `frontend/src/api/`. They are generated from the OpenAPI spec
  by `scripts/gen-api-types.sh`.
- Database migrations live in `services/api/src/main/resources/db/migration/`.
  Never edit a migration that has been merged; add a new one.
- Do not add a dependency without asking first.

## Testing

We use JUnit 5 for the backend and vitest for the frontend. Backend tests that need
a database use Testcontainers, so Docker must be running. The default test run
skips the end-to-end suite because it takes about ten minutes.

## How we work

- Commits follow Conventional Commits.
- Open a pull request for every change; do not push to main.
- Keep pull requests small.

## Frontend

The frontend has its own instructions in `frontend/AGENTS.md`.

## Contact

Questions go to the #shopfront channel.
