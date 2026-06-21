# CLAUDE.md - Jekyll Website Development Guidelines

## Project Overview
This repository contains a static website built with the Jekyll static site generator. Content is fully written in Markdown, compiled through Liquid templates, and deployed via GitHub Pages / Netlify.

## Key Development Commands
Always prepend Ruby commands with `bundle exec` to ensure the correct locked gem versions are utilized.

* **Install Ruby dependencies:** `bundle install`
* **Install Node dependencies:** `npm install`
* **Build Tailwind CSS:** `npm run build:css`
* **Build static site (full):** `npm run build:css && bundle exec jekyll build`
* **Update Ruby dependencies:** `bundle update`
* **Check for broken links (if html-proofer is configured):** `bundle exec htmlproofer ./_site`

### Development: Running the local server
Tailwind and Jekyll must run concurrently. Open two terminals:

```
# Terminal 1 — watches and recompiles Tailwind on class changes
npm run watch:css

# Terminal 2 — Jekyll dev server with live reload
bundle exec jekyll serve --livereload
```

Or with drafts: `bundle exec jekyll serve --drafts --livereload` in Terminal 2.

## Jekyll Architecture & Directory Rules
When creating or editing files, respect the core structure of Jekyll:
* **`_config.yml`**: Global settings and plugin definitions. Do not modify without explicit confirmation.
* **`_posts/`**: Blog posts. MUST follow strict file naming: `YYYY-MM-DD-short-slug.md`.
* **`_drafts/`**: Work-in-progress posts. File naming does not require the date prefix.
* **`_layouts/`**: HTML wrappers (e.g., `default.html`, `post.html`, `page.html`).
* **`_includes/`**: Reusable code snippets (partials) called via Liquid tags.
* **`_data/`**: YAML or JSON data files used for dynamic loops (menus, team, timeline).
* **`assets/`**: Images, structural CSS/SASS, and JS components. Do not put random static assets in the root.

## Code & Content Conventions

### 1. Front Matter Enforcement
Every new page or post MUST start with valid YAML Front Matter block enclosed by triple-dashed lines (`---`).
* **Required for Posts:** `layout`, `title`, `date`, and `categories` or `tags`.
* **Required for Pages:** `layout` and `title`.
* **Formatting:** Dates must use `YYYY-MM-DD HH:MM:SS +/-TTTT` or standard `YYYY-MM-DD` format.

Example:
```yaml
---
layout: post
title: "Your Post Title Here"
date: 2026-06-21 11:30:00 -0700
categories: [development, ai]
tags: [jekyll, claude]
image: /assets/images/posts/hero.jpg
---
```

### 2. Liquid Template Coding Standards
* Wrap Liquid block tags accurately: `{% tag %}` for logic and `{{ variable }}` for output.
* Always assign filtered text cleanly using Liquid filters instead of writing inline script logic (e.g., `{{ post.title | escape }}`).
* Avoid rendering computationally expensive, deeply nested nested loops over `site.posts` where possible.

### 3. Markdown Specifications
* Use strict Kramdown (default Jekyll renderer) compatible markdown syntax.
* Prefer native Markdown formatting over embedding raw HTML blocks inside post body text unless constructing complex layouts.
* Links to internal assets or pages should utilize Jekyll relative path variables (e.g., `{% link _posts/YYYY-MM-DD-slug.md %}` or `{{ '/assets/css/main.css' | relative_url }}`) to avoid broken staging paths.

## Validation & Verification Workflow
Before declaring any feature complete:
1. Run `bundle exec jekyll build` to ensure the compilation completes without Liquid rendering errors.
2. Verify that newly added Markdown files do not throw syntax errors due to unescaped special characters in YAML Front Matter strings (e.g., colons in titles must be wrapped in double quotes).
