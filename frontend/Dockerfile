# Use an official Flutter runtime as a parent image
FROM ghcr.io/cirruslabs/flutter:3.29.2

# Set the working directory
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install dependencies
RUN flutter pub get

# Build the Flutter web app with API URL
ARG API_URL=http://localhost:8000/api
RUN echo $API_URL
RUN flutter build web --dart-define=API_URL=$API_URL

# Install and configure a web server
FROM nginx:alpine
COPY --from=0 /app/build/web /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
