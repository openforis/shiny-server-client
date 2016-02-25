JSFILES := $(wildcard lib/*.js lib/decorators/*.js)
TESTS = test/*.js
REPORTER = list

all: dist/shiny-server.min.js

build: dist/shiny-server.js

dist/shiny-server.js: $(JSFILES)
	mkdir -p dist
	./node_modules/.bin/browserify lib/main.js -o dist/shiny-server.js -t babelify

dist/shiny-server.min.js: dist/shiny-server.js
	./node_modules/.bin/uglify -s dist/shiny-server.js -o dist/shiny-server.min.js

test:
	./node_modules/.bin/mocha \
		--compilers js:babel-register \
		--reporter $(REPORTER) \
		--growl \
		$(TESTS)

clean:
	rm -f dist/shiny-server.js dist/shiny-server.min.js

.PHONY: test clean all build
