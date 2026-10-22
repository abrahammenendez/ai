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
| Android | `android/skills` | `jetpack-compose-performance`, `anr-audit-and-fix` | Compose recomposition, stability and jank; ANR risks in code and ANR stack dumps. More skills in the repo for adaptive layouts, Navigation 3, testing, security, on-device AI and XR |
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
| Docker | `docker/skills` | `docker-destructive-guardrails`, `docker-build-strategies`, `docker-compose-patterns`, `docker-project-foundations`, `docker-docs` | `docker-docs` answers from current Docker docs, best with the Docker docs MCP server; see [MCP servers](#mcp-servers). The repo also covers Docker Agent and Docker Sandboxes, which run coding agents in isolated microVMs |
| Terraform | `hashicorp/agent-skills` | `terraform-style-guide`, `terraform-test`, `refactor-module`, `terraform-search-import`, `terraform-policy`, `terraform-stacks` | The repo's `provider-*` skills are for people who write Terraform providers |
| Packer | `hashicorp/agent-skills` | `aws-ami-builder`, `azure-image-builder`, `windows-builder`, `push-to-registry` | |
| AWS | `aws/agent-toolkit-for-aws` | Pick per service | Large set. Also installs as Claude Code plugins, e.g. `aws-core@claude-plugins-official`. Successor to `awslabs/agent-plugins`, per AWS |
| Azure | `microsoft/azure-skills` | Pick per service | Large set |
| Google Cloud | `google/skills` | Pick per service | Large set |
| OpenTelemetry, Prometheus, Grafana, Loki, Tempo, Mimir, Pyroscope, Alloy | `grafana/skills` | `opentelemetry`, `promql`, `prometheus`, `loki`, `tempo`, `mimir`, `pyroscope`, `alloy`, `grafana-oss`, `dashboarding`, `alerting-irm`, `app-observability` | Lean towards Grafana Cloud. The repo also covers Grafana administration and plugin development |
| k6 | `grafana/skills` | `k6` | Load tests. The repo has more k6 skills for browser tests, cloud runs and trend analysis |
| Datadog | `datadog-labs/agent-skills` | `dd-apm`, `dd-logs`, `dd-monitors` | The repo also covers RUM, SDK upgrades, security, cloud integrations and CI |

## MCP servers

Skills teach an agent how; an MCP server gives it the tools. Add a server to the projects that use it. Claude Code loads MCP tools only when a task needs them ([tool search](https://code.claude.com/docs/en/mcp)), but each server still starts with every session and adds its tool names and instructions.

Claude Code writes `--scope project` servers to `.mcp.json`, which you commit. Codex stores its servers in `~/.codex/config.toml`, for all projects.

For a server with a URL:

```bash
claude mcp add --scope project --transport http <name> <url>
codex mcp add <name> --url <url>
```

For a server that runs a command:

```bash
claude mcp add --scope project <name> -- <command>
codex mcp add <name> -- <command>
```

Servers that need credentials say how in their docs.

| Technology | Server | URL or command | Notes |
|---|---|---|---|
| Browser testing | [Playwright](https://github.com/microsoft/playwright-mcp) | `npx @playwright/mcp@latest` | Drives a real browser from accessibility snapshots. For coding agents Microsoft suggests the `playwright-cli` skill instead, because it costs fewer tokens. The server suits loops that keep one browser open between steps |
| Web debugging and performance | [Chrome DevTools](https://github.com/ChromeDevTools/chrome-devtools-mcp) | `npx -y chrome-devtools-mcp@latest` | From the Chrome team. Performance traces, network requests, console and screenshots in a real Chrome. Also installs as a Claude Code plugin from the same repo |
| Figma | [Figma](https://developers.figma.com/docs/figma-mcp-server/) | `https://mcp.figma.com/mcp` | Reads designs and writes to the canvas. The `figma@claude-plugins-official` plugin bundles it with Figma's skills. The desktop server is for specific organization and enterprise needs |
| GitHub | [GitHub](https://github.com/github/github-mcp-server) | `https://api.githubcopilot.com/mcp/` | For Claude Code, GitHub's guide passes a personal access token with `-H "Authorization: Bearer <token>"`. The `gh` CLI does most of the same work |
| Docker | [Docker docs](https://github.com/docker/skills) | `https://ai-backend-service.docker.com/mcp` | Searches current Docker docs, for the `docker-docs` skill. The `docker-skills@docker` plugin, from marketplace `docker/skills`, bundles both |
| Terraform | [Terraform](https://github.com/hashicorp/terraform-mcp-server) | `docker run -i --rm hashicorp/terraform-mcp-server` | Looks up providers and modules in the Terraform Registry, and works with HCP Terraform |
| MongoDB | [MongoDB](https://github.com/mongodb-js/mongodb-mcp-server) | `npx -y mongodb-mcp-server@latest --readOnly` | Queries a database or Atlas cluster. Takes the connection string from `MDB_MCP_CONNECTION_STRING`. `npx -y mongodb-mcp-server@latest setup` walks you through it |
| Redis | [Redis](https://github.com/redis/mcp-redis) | `uvx --from git+https://github.com/redis/mcp-redis.git redis-mcp-server --url redis://localhost:6379/0` | Reads and writes data in a Redis instance |
| Kafka, Flink | [Confluent](https://github.com/confluentinc/mcp-confluent) | `npx -y @confluentinc/mcp-confluent --config ./config.yaml` | Kafka, Flink SQL, Schema Registry and connectors on Confluent Cloud. `--init-config` writes the config file |
| PostgreSQL on Supabase | [Supabase](https://github.com/supabase/mcp) | `https://mcp.supabase.com/mcp` | Add `?project_ref=<ref>&read_only=true` to the URL to keep it to one project, read only |
| Grafana, Prometheus, Loki | [Grafana](https://github.com/grafana/mcp-grafana) | `uvx mcp-grafana` | Takes `GRAFANA_URL` and `GRAFANA_SERVICE_ACCOUNT_TOKEN` |
| Datadog | [Datadog](https://docs.datadoghq.com/bits_ai/mcp_server/) | `https://mcp.datadoghq.com/v1/mcp` | For the US1 site. Other sites have their own host, such as `mcp.datadoghq.eu` |
| Vercel | [Vercel](https://vercel.com/docs/mcp) | `https://mcp.vercel.com` | Deployments, logs, projects and domains |
| AWS | [AWS](https://github.com/aws/agent-toolkit-for-aws) | `https://aws-mcp.us-east-1.api.aws/mcp` | Signs requests with your AWS credentials through `uvx mcp-proxy-for-aws-cli@latest <url>`. The `aws-core@claude-plugins-official` plugin bundles it with AWS's skills |
| Azure | [Azure](https://learn.microsoft.com/azure/developer/azure-mcp-server/) | `npx -y @azure/mcp@latest server start` | All Azure services in one server |
| Google Cloud | [Google Cloud](https://github.com/google/mcp) | Pick per service | Google runs a remote server per service, which you enable in each Google Cloud project |
| Microsoft and Azure docs | [Microsoft Learn](https://github.com/MicrosoftDocs/mcp) | `https://learn.microsoft.com/api/mcp` | Searches and fetches official Microsoft docs and code samples |
| IntelliJ IDEA and other JetBrains IDEs | [JetBrains IDE](https://www.jetbrains.com/help/idea/mcp-server.html) | Built into the IDE | Gives the agent the IDE's own tools. Turn it on in Settings, Tools, MCP Server, then use Auto-Configure for Claude Code or Codex |

## Other sources

- **Spring Boot:** the Spring team's Spring Tools plugin for Claude Code. It runs the Spring language server and checks Spring code after each edit. It starts a Java process in every session, so enable it per project:

  ```bash
  claude plugin marketplace add https://cdn.spring.io/spring-tools/release/claude-plugins/marketplace.json
  claude plugin install spring-tools@spring-tools-marketplace --scope local
  ```

  I found no skills published by the Spring projects themselves.

## Watching

- `trailofbits/skills`: the `patching-bugs` and `regression-hunt` plugins, added in October. One reproduces, patches and proves a fix for a named bug; the other hunts regressions in PRs and commits. Each runs a long, recorded workflow, and `patching-bugs` needs `regression-hunt`. Their skills read files outside their own folders, so install them as plugins (`/plugin marketplace add trailofbits/skills`), not with `npx skills`.
- `wheresryan22/anatomy`: draws a technical idea as an interactive isometric figure of a machine, for docs, articles and landing pages. Not tied to a technology. Its description also matches plain diagram requests, so install it only in projects that need such figures.
