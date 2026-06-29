# Silver Sanctuary — Website

Modern, fast, responsive marketing site for **Silver Sanctuary**, an assisted living community in Carmichael, CA.

This is **Phase 1**: a static **HTML + CSS + vanilla JS** build. It is designed to later port into a **Django + PostgreSQL** app (see `.claude/REDESIGN_PLAN.md`).

## Pages

| File | Page |
|------|------|
| `index.html` | Home |
| `care.html` | Care & Services |
| `life.html` | Life at Silver Sanctuary (activities, meals, community) |
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

## Build & run the Docker image locally

Make sure Docker Desktop is running, then from this folder:

```bash
# Build
docker build -t sapphire-site .

# Run (maps host 8080 -> container PORT 8080)
docker run --rm -p 8080:8080 -e PORT=8080 sapphire-site
# open http://localhost:8080
```

The image is `nginx:alpine` serving the static files. At startup nginx renders
`nginx.conf.template`, substituting `$PORT` (locally 8080, on Railway whatever
Railway injects).

## Deploy to Railway (Docker)

1. **Push to a Git repo** (GitHub/GitLab).
2. In Railway: **New Project → Deploy from GitHub repo** and pick this repo.
   Railway auto-detects the `Dockerfile` and builds it (no Nixpacks/buildpack needed).
3. Railway sets the `PORT` env var automatically and routes traffic to it — the
   container already listens on `$PORT`, so **no extra config is required**.
   (You do *not* need to manually add a `PORT` variable.)
4. Wait for the build/deploy to finish, then open the generated
   `*.up.railway.app` URL to verify.
5. **Custom domain:** Settings → Networking → *Custom Domain* → add
   `sapphiresenior.care` (and `www`), then add the CNAME record Railway shows you
   at your DNS provider. HTTPS is issued automatically.

> Quick free preview alternative: push to **GitHub Pages** (serve the repo root).

## Formspree (contact form) — no API key or backend needed

The contact form (`contact.html`) posts **directly from the browser** to Formspree:

```html
<form action="https://formspree.io/f/mldedaqk" method="POST"> ... </form>
```

Because it's a plain HTML POST to Formspree's hosted endpoint, there is **nothing
to configure in Docker or Railway** — no environment variable, no secret, no API
key lives in the container. To make it live:

1. Log in to **formspree.io** with the account that owns form `mldedaqk`
   (or create a new form and replace that ID in `contact.html`).
2. In the form's settings, set the **destination email** that should receive leads.
3. **Activate it:** submit the form once on the deployed site; Formspree emails a
   one-time confirmation link to the destination address — click it. After that,
   submissions arrive by email.
4. (Optional) Enable Formspree's **reCAPTCHA / spam filtering**. The form already
   includes a hidden `_gotcha` honeypot field for basic bot protection.

> Future Django phase: the form will instead POST to a Django view that saves
> submissions to PostgreSQL (and can still forward to email). That's when you'd
> introduce real env vars/secrets (DB URL, email creds) in Railway.

## Notes

- **Payment badges** on `rooms.html` (PayPal / Amazon Pay / Apple Pay) are **display-only / non-functional** — clearly labeled. Real payment integration is a future task.
- **Future Django port:** header/footer become template partials; the contact form posts to a Django view that writes submissions to PostgreSQL; `css/`, `js/`, `assets/` move into `static/`.
- Fonts load from Google Fonts (preconnect + `display=swap`); self-hosting is a later optimization.
