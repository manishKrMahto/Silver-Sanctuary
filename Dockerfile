# Silver Sanctuary - static site served by nginx (Railway-ready)
FROM nginx:1.27-alpine

# nginx:alpine renders templates in /etc/nginx/templates at startup,
# substituting env vars (e.g. Railway's $PORT) into the final config.
COPY nginx.conf.template /etc/nginx/templates/default.conf.template

# Copy only the site files into the web root (no Dockerfile/config/docs).
COPY *.html /usr/share/nginx/html/
COPY robots.txt sitemap.xml /usr/share/nginx/html/
COPY css/   /usr/share/nginx/html/css/
COPY js/    /usr/share/nginx/html/js/
COPY assets/ /usr/share/nginx/html/assets/

# Railway injects $PORT at runtime; default to 8080 for local runs.
ENV PORT=8080
EXPOSE 8080
