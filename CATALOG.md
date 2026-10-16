# Catalog

Skills, plugins and MCP servers worth adding to a project that uses the technology. Nothing here is installed by `setup.sh`. Each entry comes from the maker of the technology unless the notes say otherwise.

Last reviewed: 2026-10.

## Adding a skill to a project

Run in the project root:

```bash
npx skills add <repo> -a claude-code codex -y -s <skill>...
```

The skills land in the project's `.agents/skills`, which Codex reads, with links in `.claude/skills` for Claude Code. Commit both folders so everyone working on the project gets them.

## Skills

Where a repo holds more skills than listed, the notes say what the rest cover. A repo's skills for its own products, for people who build the technology itself, or for authoring skills are left out.

| Technology | Repo | Skills | Notes |
|---|---|---|---|
| Kotlin + JPA | `Kotlin/kotlin-agent-skills` | `kotlin-backend-jpa-entity-mapping` | Entity design, identity and equality, fetch rules. The repo also covers AGP 9, CocoaPods and Kotlin Toolchain migrations |
| Java to Kotlin | `Kotlin/kotlin-agent-skills` | `kotlin-tooling-java-to-kotlin` | For migrations |
| Kotlin + Spring: code | `yalishevant/kotlin-backend-agent-skills` | `spring-kotlin-code-review`, `kotlin-spring-proxy-compatibility`, `spring-context-di-reasoning`, `configuration-properties-profiles-kotlin-safe`, `jackson-kotlin-serialization-specialist`, `jpa-spring-data-kotlin-mapper`, `transaction-consistency-designer`, `spring-mvc-webflux-api-builder`, `error-model-validation-architect`, `spring-security-configurator-auditor`, `kotlin-idiomatic-refactorer-spring-aware`, `test-suite-builder` | By a JetBrains product manager, not the Kotlin team; JetBrains lists it in its verified catalog, `JetBrains/skills`. `Kotlin/kotlin-backend-agent-skills` redirects to it. `jpa-spring-data-kotlin-mapper` overlaps with `kotlin-backend-jpa-entity-mapping` above; pick one |
| Kotlin + Spring: build and operations | `yalishevant/kotlin-backend-agent-skills` | `project-context-ingestion`, `gradle-kotlin-dsl-doctor`, `dependency-conflict-resolver`, `upgrade-breaking-change-navigator`, `schema-migration-planner`, `ci-cd-containerization-advisor`, `integration-resilience-engineer`, `observability-integrator`, `performance-concurrency-advisor`, `stacktrace-log-triage`, `production-incident-responder`, `domain-decomposition-api-design-advisor`, `java-kotlin-migration-assistant` | Same repo. `java-kotlin-migration-assistant` overlaps with `kotlin-tooling-java-to-kotlin` above. The repo has had no commits since March |
| Kafka | `confluentinc/agent-skills` | `developing-kafka-java-client`, `kafka-streams-programming`, `kafka-schema-registry`, `confluent-tuning-advisor` | Lean towards Confluent Cloud. The repo also covers the Python client, CDC and MSK migration |
| Flink | `confluentinc/agent-skills` | `flink-udf`, `confluent-cloud-flink-sql` | Java UDFs, and Flink SQL on Confluent Cloud |
| GraphQL | `apollographql/skills` | `graphql-schema`, `graphql-operations` | Any stack |
| Apollo | `apollographql/skills` | `apollo-kotlin`, `apollo-server`, `apollo-client`, `apollo-ios`, `apollo-federation`, `apollo-router`, `apollo-connectors`, `rover`, `apollo-mcp-server` | Pick the ones you use |
| React | `vercel-labs/agent-skills` | `vercel-react-best-practices`, `vercel-composition-patterns`, `vercel-react-view-transitions` | From Vercel; the React team publishes none |
| React Native | `vercel-labs/agent-skills` | `vercel-react-native-skills` | From Vercel. Expo publishes its own in `expo/skills`, not reviewed here |
| Next.js | `vercel/next.js` | `next-bundle-optimizer`, `next-cache-components-adoption`, `next-cache-components-optimizer`, `next-dev-loop`, `next-partial-prefetching-adoption`, `next-partial-prefetching-optimizer` | From the framework's repo, in its `skills` folder. The repo's `.agents/skills` folder is for people working on Next.js itself. Cache Components and Partial Prefetching are newer features, so check your version supports them |
| Vercel | `vercel-labs/agent-skills` | `deploy-to-vercel`, `vercel-cli-with-tokens`, `vercel-optimize` | Deploys, token-based CLI use, and cost and performance work on deployed projects |
| Web frontend | `GoogleChrome/modern-web-guidance` | `modern-web-guidance`, `chrome-extensions` | From the Chrome team |
| Web UI review | `vercel-labs/agent-skills` | `web-design-guidelines` | Checks UI code against the Web Interface Guidelines. A review rubric, not tied to a framework |
| Jetpack Compose | `android/skills` | `jetpack-compose-performance` | Recomposition, stability and jank. More skills in the repo for adaptive layouts, Navigation 3, testing and security |
| Playwright | `microsoft/playwright-cli` | `playwright-cli` | Needs the `playwright-cli` command. Microsoft suggests it over the MCP server for coding agents; see [MCP servers](#mcp-servers) |
| Figma | `figma/mcp-server-guide` | `figma-use`, `figma-design-to-code`, `figma-code-connect`, `figma-generate-design`, `figma-generate-library` | Need the Figma MCP server; see [MCP servers](#mcp-servers). The repo also covers FigJam, Slides, motion, shaders and SwiftUI. `openai/skills` has Figma skills too, but from OpenAI |
| Web app security | `openai/skills` | `security-best-practices` | Rules for JS/TS, Python and Go frameworks only; nothing for the JVM |
| Threat modelling | `openai/skills` | `security-threat-model` | Any stack; starts only when asked |
| Property-based tests | `trailofbits/skills` | `property-based-testing` | Covers jqwik for Java and Kotlin |
| PostgreSQL | `supabase/agent-skills` | `supabase-postgres-best-practices` | From Supabase, mostly generic Postgres |
| PostgreSQL, MySQL | `planetscale/database-skills` | `postgres`, `mysql` | From PlanetScale |
| MongoDB | `mongodb/agent-skills` | `mongodb-schema-design`, `mongodb-query-optimizer`, `mongodb-connection`, `mongodb-search-and-ai` | The repo also covers natural-language queries, stream processing and MCP setup |
| Redis | `redis/agent-skills` | `redis-core`, `redis-connections`, `redis-clustering`, `redis-security`, `redis-observability`, `redis-search` | The repo also covers Redis Cloud's AI products |
| Oracle Database | `oracle/skills` | `db` | The repo also covers APEX, Fusion and OCI |
| GraalVM | `oracle/skills` | `graal` | Native Image builds with Maven or Gradle |
| Docker | `docker/skills` | `docker-destructive-guardrails`, `docker-build-strategies`, `docker-compose-patterns`, `docker-project-foundations` | The repo also covers Docker Agent and Docker Sandboxes, which run coding agents in isolated microVMs |
| Terraform | `hashicorp/agent-skills` | `terraform-style-guide`, `terraform-test`, `refactor-module`, `terraform-search-import`, `terraform-policy`, `terraform-stacks` | The repo's `provider-*` skills are for people who write Terraform providers |
| Packer | `hashicorp/agent-skills` | `aws-ami-builder`, `azure-image-builder`, `windows-builder`, `push-to-registry` | |
| AWS | `aws/agent-toolkit-for-aws` | Pick per service | Large set. Also installs as Claude Code plugins, e.g. `aws-core@claude-plugins-official`. Successor to `awslabs/agent-plugins`, per AWS |
| Azure | `microsoft/azure-skills` | Pick per service | Large set |
| Google Cloud | `google/skills` | Pick per service | Large set |
| OpenTelemetry, Prometheus, Grafana, Loki, Tempo, Mimir, Pyroscope, Alloy | `grafana/skills` | `opentelemetry`, `promql`, `prometheus`, `loki`, `tempo`, `mimir`, `pyroscope`, `alloy`, `grafana-oss`, `dashboarding`, `alerting-irm`, `app-observability` | Lean towards Grafana Cloud. The repo also covers Grafana administration and plugin development |
| k6 | `grafana/skills` | `k6` | Load tests. The repo has more k6 skills for browser tests, cloud runs and trend analysis |
| Datadog | `datadog-labs/agent-skills` | `dd-apm`, `dd-logs`, `dd-monitors` | The repo also covers RUM, SDK upgrades, security, cloud integrations and CI |

## MCP servers

Skills teach an agent how; an MCP server gives it the tools. Add them to a project, not globally: each one adds tool definitions to every session's context.

Claude Code writes `--scope project` servers to `.mcp.json`, which you commit. Codex stores its servers in `~/.codex/config.toml`, for all projects.

- **Playwright:** drives a real browser from accessibility snapshots, for testing and checking a running app. Microsoft's own advice is to use the [Playwright CLI](https://github.com/microsoft/playwright-cli) with its skill for coding agents, because the CLI costs fewer tokens. The MCP server suits loops that need a browser that stays open between steps. See the [Playwright MCP repo](https://github.com/microsoft/playwright-mcp).

  ```bash
  claude mcp add --scope project playwright npx @playwright/mcp@latest
  codex mcp add playwright npx "@playwright/mcp@latest"
  ```

- **Figma:** reads designs, and with the remote server writes to the canvas. Use the remote server; the desktop one is for specific organization and enterprise needs. The Figma plugin for Claude Code bundles the server and Figma's skills. See [Figma's setup guide](https://developers.figma.com/docs/figma-mcp-server/).

  ```bash
  claude plugin install figma@claude-plugins-official
  # or the server alone
  claude mcp add --scope project --transport http figma https://mcp.figma.com/mcp
  codex mcp add figma --url https://mcp.figma.com/mcp
  ```

## Other sources

- **Spring Boot:** the Spring team's Spring Tools plugin for Claude Code. It runs the Spring language server and checks Spring code after each edit. It starts a Java process in every session, so enable it per project:

  ```bash
  claude plugin marketplace add https://cdn.spring.io/spring-tools/release/claude-plugins/marketplace.json
  claude plugin install spring-tools@spring-tools-marketplace --scope local
  ```

  I found no skills published by the Spring projects themselves.

## Watching

- `wheresryan22/anatomy`: draws a technical idea as an interactive isometric figure of a machine, for docs, articles and landing pages. Not tied to a technology. Its description also matches plain diagram requests, so install it only in projects that need such figures.
