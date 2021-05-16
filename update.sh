#!/bin/bash

update_backend() {
	echo "Updating backend"

	cd /var/www/backend
	git pull
	cd /var/www/deploy
	docker-compose up -d --no-deps --build backend scheduler
	docker-compose exec backend php artisan migrate --force
}

update_frontend() {
	echo "Updating frontend"
	echo "No scripts for frontend yet."
}

updated_all() {
	echo "Updating all"
	update_backend
	update_frontend
}

if [[ $1 = "backend" ]]; then
	update_backend
elif [[ $1 = "frontend" ]]; then
	update_frontend
else
	updated_all
fi
