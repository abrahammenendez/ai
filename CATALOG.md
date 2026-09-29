# Catalog

Skills and plugins worth adding to a project that uses the technology. Nothing here is installed by `setup.sh`. Each entry comes from the maker of the technology unless the notes say otherwise.

Last reviewed: 2026-09.

## Adding a skill to a project

Run in the project root:

```bash
npx skills add <repo> -a claude-code codex -y -s <skill>...
```

The skills land in the project's `.agents/skills`, which Codex reads, with links in `.claude/skills` for Claude Code. Commit both folders so everyone working on the project gets them.

## Skills

| Technology | Repo | Skills | Notes |
|---|---|---|---|
| Kotlin + JPA | `Kotlin/kotlin-agent-skills` | `kotlin-backend-jpa-entity-mapping` | Entity design, identity and equality, fetch rules |
| Java to Kotlin | `Kotlin/kotlin-agent-skills` | `kotlin-tooling-java-to-kotlin` | For migrations |
| Kafka | `confluentinc/agent-skills` | `developing-kafka-java-client`, `kafka-streams-programming`, `kafka-schema-registry` | Leans towards Confluent Cloud |
| GraphQL | `apollographql/skills` | `graphql-schema`, `graphql-operations`, `apollo-kotlin`, `apollo-server`, `apollo-client` | Pick the client or server you use |
| React | `vercel-labs/agent-skills` | `vercel-react-best-practices`, `vercel-composition-patterns` | From Vercel; the React team publishes none |
| Web frontend | `GoogleChrome/modern-web-guidance` | `modern-web-guidance` | From the Chrome team |
| Web app security | `openai/skills` | `security-best-practices` | Rules for JS/TS, Python and Go frameworks only; nothing for the JVM |
| Threat modelling | `openai/skills` | `security-threat-model` | Any stack; starts only when asked |
| Property-based tests | `trailofbits/skills` | `property-based-testing` | Covers jqwik for Java and Kotlin |
| PostgreSQL | `supabase/agent-skills` | `supabase-postgres-best-practices` | From Supabase, mostly generic Postgres |
| PostgreSQL, MySQL | `planetscale/database-skills` | `postgres`, `mysql` | From PlanetScale |
| MongoDB | `mongodb/agent-skills` | `mongodb-schema-design`, `mongodb-query-optimizer` | |
| Redis | `redis/agent-skills` | `redis-core` | More skills in the repo for search, clustering and security |
| Oracle Database | `oracle/skills` | `db` | |
| Docker | `docker/skills` | `docker-destructive-guardrails`, `docker-build-strategies`, `docker-compose-patterns` | |
| Terraform | `hashicorp/agent-skills` | `terraform-style-guide`, `terraform-test` | |
| Azure | `microsoft/azure-skills` | Pick per service | Large set |
| Google Cloud | `google/skills` | Pick per service | Large set |
| OpenTelemetry, Prometheus, Grafana, Loki, Tempo, Alloy | `grafana/skills` | `opentelemetry`, `promql`, `loki`, `tempo`, `alloy` | Leans towards Grafana Cloud |
| Datadog | `datadog-labs/agent-skills` | `dd-apm`, `dd-logs`, `dd-monitors` | |

## Other sources

- **Spring Boot:** the Spring team's Spring Tools plugin for Claude Code. It runs the Spring language server and checks Spring code after each edit. It starts a Java process in every session, so enable it per project:

  ```bash
  claude plugin marketplace add https://cdn.spring.io/spring-tools/release/claude-plugins/marketplace.json
  claude plugin install spring-tools@spring-tools-marketplace --scope local
  ```

- **Next.js:** the framework ships version-matched docs and an `AGENTS.md` that points to them; see its [AI agents guide](https://nextjs.org/docs/app/guides/ai-agents). The `vercel/next.js` repo also ships skills, not yet reviewed here.

## Nothing official yet

JPA and Hibernate in general, R2DBC, Liquibase, Flyway, gRPC, SOAP, OpenAPI, Kubernetes, Spring Cloud, JUnit, Mockito, MockK, AssertJ, REST Assured, MockServer, Testcontainers for Java, Caffeine, Micrometer, OAuth, OIDC, JWT, GitHub Actions, Gradle, Maven.

## Watching

- `yalishevant/kotlin-backend-agent-skills`: Spring and Kotlin backend skills by a JetBrains product manager. Good content, but no changes since it was published.
