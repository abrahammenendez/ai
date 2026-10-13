# Tripmates

## Context

Tripmates started as a side project in 2024 after a group holiday where nobody could
agree on a budget. Friends who travel together plan the trip in one place: where to go,
what to book, who pays for what. The founders are two engineers who still work on it in
the evenings.

The target user is a group of four to eight friends in their late twenties and thirties.
One person, the organiser, creates the trip and invites the rest by link. Everyone else
joins without creating an account, which keeps the first experience quick.

## Product flow

1. The organiser creates a trip with a name, rough dates and a destination.
2. The organiser shares the invite link in the group chat.
3. Members join with a display name and add their available dates.
4. The app shows the dates that work for the most people.
5. Members propose activities and accommodation, and vote on them.
6. Once the group agrees, the organiser marks items as booked.
7. During the trip, members log expenses and the app computes who owes whom.
8. After the trip, the app shows a settlement summary and a shared photo album link.

Voting is deliberately simple: one up-vote per member per proposal. We tried ranked
voting in an early prototype and testers found it confusing.

## Architecture

Tripmates is a monorepo using npm workspaces.

- `apps/web` is the single-page app, built with Vite.
- `apps/api` is the backend, a small Node service written in TypeScript.
- `packages/shared` holds types shared by both apps.

The web app talks to the API over HTTP and JSON. The API stores data in PostgreSQL.
Real-time updates for votes use server-sent events, because they are simpler to run
than WebSockets behind our hosting provider's proxy.

### Data model

A trip has many members, proposals, votes and expenses. Members belong to exactly one
trip. There is no global user table yet; a member is identified by a token stored in
the browser. This is a known limitation and the first item on the roadmap.

### Deployment

The web app is deployed as static files to a CDN. The API runs as a single container on
a managed platform. The database is a managed PostgreSQL instance. Staging and
production are separate environments with separate databases.

## Design principles

- Make the first minute effortless. No sign-up before value.
- Prefer boring technology we already know.
- Small, reviewable pull requests.
- Write code that is easy to read.
- Handle errors gracefully.
- Keep the UI fast on mid-range phones.

## Roadmap

### Phase 1: foundations (done)

- Trip creation and invite links
- Availability picker
- Proposals and voting

### Phase 2: money (in progress)

- Expense logging
- Settlement calculation
- Currency support for the ten most common travel currencies

### Phase 3: accounts

- Optional accounts so members can see all their trips
- Email reminders for open votes
- Trip history

### Phase 4: growth

- Public trip templates
- Calendar export
- Mobile app wrapper

## Team and process

The team is two engineers and one part-time designer. We meet on Mondays to pick the
week's work. Designs live in Figma; ask the designer for access.

We ship to staging on every merge to main and to production on Thursdays.

## Glossary

- **Trip**: a planning space for one group holiday.
- **Member**: a person in a trip.
- **Proposal**: an activity or place someone suggests.
- **Settlement**: the list of payments that clears all debts.

## Commands

- Install: `npm install`
- Build everything: `npm run build`
- Test everything: `npm test`
- Lint: `npm run lint`
- Web dev server: `npm run dev --workspace @tripmates/web`
- API dev server: `npm run dev --workspace @tripmates/api`
- Run the staging deploy script: `./scripts/deploy-staging.sh`

## Coding standards

- TypeScript strict mode everywhere.
- Format with Prettier before committing.
- Prefer small functions.
- Name things clearly.
- Write tests for new features.

## Rules

- Types shared between apps live in `packages/shared/src/`. Do not duplicate them in an app.
- Do not add a dependency without asking first.

## Open questions

- Should proposals expire after a deadline?
- Do we need per-member currencies for expenses?
- Is server-sent events still the right choice once we add accounts?

## History

- 2024-03: first prototype with ranked voting
- 2024-06: switched to simple up-votes
- 2024-09: private beta with five friend groups
- 2025-01: public launch of phase 1

## Links

- Design files: ask the designer
- Staging: see the team wiki
- Production: see the team wiki

## How we work

- Commits follow Conventional Commits.
- Open a pull request for every change; do not push to main.
