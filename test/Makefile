all: run

build:
	docker build -t test/test:1 .

run: build
	docker run --name=apache-test1 -p 80:80 test/test:1 
