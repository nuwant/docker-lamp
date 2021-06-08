test: build up run-tests clean

test-no-cache: build-no-cache up run-tests clean

build:
	docker-compose -f docker-compose.test.yml -p ci build

build-no-cache:
	docker-compose -f docker-compose.test.yml -p ci build --no-cache

up:
	docker-compose -f docker-compose.test.yml -p ci up -d
	
ssh:
	docker-compose -f docker-compose.test.yml -p ci ps

sh:
	docker exec -ti ci_web1804-php8_1 bash

#check:
  #docker exec -it ci_web1804-php8_1 bash -c "php -v"
  #docker exec -it ci_web1804-php8_1 bash -c "composer -V"
  #docker exec -it ci_web1804-php8_1 bash -c "cd .. && composer install -vvv"

run-tests:
	cd tests && ./test.sh

clean:
	docker-compose -f docker-compose.test.yml -p ci down
