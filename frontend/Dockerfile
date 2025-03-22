# Use an official Flutter runtime as a parent image
FROM ghcr.io/cirruslabs/flutter:3.29.2

# Set the working directory
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install dependencies
RUN flutter pub get

# Build the Flutter web app
RUN flutter build web

# Install and configure a web server
FROM nginx:alpine
COPY --from=0 /app/build/web /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
