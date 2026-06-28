# Sapphire Senior Care — static site served by nginx (Railway-ready)
FROM nginx:1.27-alpine

# Copy the static site into nginx's web root
COPY . /usr/share/nginx/html

# Railway provides $PORT; render a config that listens on it at startup.
# (nginx:alpine supports the /etc/nginx/templates -> envsubst mechanism.)
COPY nginx.conf.template /etc/nginx/templates/default.conf.template

ENV PORT=8080
EXPOSE 8080
