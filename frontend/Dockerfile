# Use the official NGINX base image
FROM nginx:latest

# Copy your custom configuration file
COPY nginx.conf /etc/nginx/nginx.conf

# Copy your static website files
COPY . /usr/share/nginx/html

EXPOSE 80