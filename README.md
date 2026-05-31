# Traveller Library Data

A personal campaign wiki for the Traveller science-fiction RPG In My Traveller Universe (IMTU).

built with Jekyll and Tailwind CSS. Pages are written in Markdown and compiled to a dark holographic-themed static site.

---

## Prerequisites

| Tool | Version |
|------|---------|
| Ruby | 3.x |
| Bundler | `gem install bundler` |
| Node.js | 18+ |

---

## Setup

```bash
bundle install   # Ruby gems (Jekyll, plugins)
npm install      # Tailwind CSS CLI
```

---

## Building

Tailwind and Jekyll must run separately. For development, open two terminals:

```bash
# Terminal 1 — recompile CSS whenever Tailwind classes change
npm run watch:css

# Terminal 2 — Jekyll dev server with live reload
bundle exec jekyll serve --livereload
```

For a one-shot production build:

```bash
npm run build:css && bundle exec jekyll build
```

The compiled site is written to `_site/`.

---

## Adding Content

All content lives in Markdown files with YAML front matter. Every file must begin with a `---` front matter block.

### People (`_people/`)

```yaml
---
layout: entry
title: "Anya Voss"
status: Active
faction: Free Traders Guild
location: regina          # slug of a location document (optional)
race: Human (Solomani)
class: Merchant Captain
tags: [free-trader, merchant]
---

Narrative text here.
```

### Factions (`_factions/`)

```yaml
---
layout: entry
title: "Free Traders Guild"
status: Active
tags: [trade, organization]
---
```

### Locations (`_locations/`)

Locations form a four-level hierarchy: **Domain → Sector → Subsector → World**. Each level is a Markdown file nested in a matching subdirectory so that the URL structure mirrors the hierarchy.

```
_locations/
  domain-of-deneb.md
  domain-of-deneb/
    spinward-marches.md
    spinward-marches/
      regina-subsector.md
      regina-subsector/
        regina.md
```

**Domain** (`type: domain`):

```yaml
---
layout: entry
title: "Domain of Deneb"
type: domain
allegiance: Third Imperium
tags: [domain, third-imperium]
---
```

**Sector** (`type: sector`):

```yaml
---
layout: entry
title: "Spinward Marches"
type: sector
parent: domain-of-deneb    # slug of the parent domain file
allegiance: Third Imperium
tags: [sector, spinward-marches]
---
```

**Subsector** (`type: subsector`):

```yaml
---
layout: entry
title: "Regina Subsector"
type: subsector
parent: spinward-marches   # slug of the parent sector file
position: C
tags: [subsector]
---
```

**World** (`type: world`):

```yaml
---
layout: entry
title: "Regina"
type: world
parent: regina-subsector   # slug of the parent subsector file
uwp: A788899-C
allegiance: Third Imperium
bases: Naval, Scout
tags: [world, capital]
---
```

The `parent:` value is the filename of the parent document without its `.md` extension. Jekyll uses this to build breadcrumb navigation and the "Contains" child list automatically.

### Journal Posts (`_posts/`)

Blog-style session notes. Filenames must follow Jekyll's `YYYY-MM-DD-slug.md` format:

```yaml
---
layout: post
title: "Session 1: Arrival at Regina"
date: 2026-06-21
tags: [session, regina]
---
```

---

## Tags

Tags are **automatic** — no separate tag file is required. Add any tag to a document's `tags:` list in front matter and a tag index page at `/tags/<slug>/` will be generated on the next build. Tag pages list all entries with that tag in alphabetical order, indexed by first letter.

---

## Customising the Theme

Tailwind source lives in `_tailwind/input.css`. Custom colour tokens, component classes, and the holographic glow helpers are all defined there. After any CSS change, run `npm run build:css` (or the watch process) to recompile `assets/css/main.css`.

Do not edit `assets/css/main.css` directly — it is overwritten on every build.
