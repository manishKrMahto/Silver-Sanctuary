# Sapphire Senior Care — Website

Modern, fast, responsive marketing site for **Sapphire Senior Care**, an assisted living community in Roseville, CA.

This is **Phase 1**: a static **HTML + CSS + vanilla JS** build. It is designed to later port into a **Django + PostgreSQL** app (see `.claude/REDESIGN_PLAN.md`).

## Pages

| File | Page |
|------|------|
| `index.html` | Home |
| `care.html` | Care & Services |
| `life.html` | Life at Sapphire (activities, meals, community) |
| `rooms.html` | Rooms & Pricing (+ dummy payment badges) |
| `safety.html` | Safety & Privacy |
| `gallery.html` | Gallery (lightbox) |
| `faq.html` | FAQ (10 questions, accordion) |
| `contact.html` | Contact / Book a tour (Formspree form + map) |
| `404.html` | Not-found page |

## Project structure

```
.
├── *.html              # pages
├── css/styles.css      # all styles + design tokens
├── js/main.js          # menu, FAQ accordion, lightbox, scroll reveal
├── assets/             # logo, building, room & gallery images
├── robots.txt, sitemap.xml
├── Dockerfile, nginx.conf.template, .dockerignore   # Railway deploy
└── .claude/REDESIGN_PLAN.md
```

## Run locally

No build step. Use any static server, e.g.:

```bash
# Python
python -m http.server 8080
# then open http://localhost:8080
```

## Deploy to Railway (Docker)

1. Push this folder to a Git repo.
2. In Railway: **New Project → Deploy from repo**. Railway detects the `Dockerfile`.
3. The container serves the static site via nginx on Railway's `$PORT`.
4. Add your custom domain (`sapphiresenior.care`) in Railway settings.

> For a quick free preview you can also push to **GitHub Pages** (serve the repo root).

## Notes

- **Payment badges** on `rooms.html` (PayPal / Amazon Pay / Apple Pay) are **display-only / non-functional** — clearly labeled. Real payment integration is a future task.
- **Future Django port:** header/footer become template partials; the contact form posts to a Django view that writes submissions to PostgreSQL; `css/`, `js/`, `assets/` move into `static/`.
- Fonts load from Google Fonts (preconnect + `display=swap`); self-hosting is a later optimization.
