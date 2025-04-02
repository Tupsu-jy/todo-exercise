#!/bin/bash

# Start database if it exists
docker start todo-exercise-db || echo "Error: Could not start database container"

# Start PHP server
gnome-terminal --tab --title="PHP Server" -- bash -c "cd api && php artisan serve; exec bash"

# Start Reverb server
gnome-terminal --tab --title="Reverb Server" -- bash -c "cd api && php artisan reverb:start; exec bash"

# Start Flutter
gnome-terminal --tab --title="Flutter" -- bash -c "cd frontend && flutter run -d chrome; exec bash"

echo "All services started!"