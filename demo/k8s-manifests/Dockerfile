FROM phusion/passenger-full:latest
RUN mkdir -p /opt/public/html
WORKDIR /opt/public/html
COPY index.html .
COPY passenger /etc/nginx/sites-enabled/
RUN rm -rf  /etc/nginx/sites-enabled/default
CMD service nginx restart
EXPOSE 80
