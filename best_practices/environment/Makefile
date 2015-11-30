COFFEE_DIR = ./public/assets/coffee
JS_DIR = ./public/assets/js
SASS_DIR = ./public/assets/sass
CSS_DIR = ./public/assets/css
PID_FILE = .watchers

all: build

build: sass coffee require
prod: sass coffee require remove_js move_built_file

sass:
	@echo "Compiling SASS..."
	@`which sass` --compass --style=compressed ${SASS_DIR}:${CSS_DIR} --update

sass_watch:
	exec sass --watch public/assets/sass:public/assets/css -t compact --compass

webpack:
	@echo "Running webpack in watch mode"
	exec webpack --progress -cdw --display-error-details --display-chunks

minify:
	exec webpack --progress -cdp

watch:
	@echo "Running sass and webpack in watch mode"
	@`which sass` --watch public/assets/sass:public/assets/css -t compact --compass &> /dev/null & echo $$! >> ${PID_FILE}
	@`webpack -dw` assets/coffee public/assets/js &> /dev/null & echo $$! >> ${PID_FILE}

unwatch:
	@if [ -f ${PID_FILE} ]; then \
        echo 'Watchers stopped'; \
        for pid in `cat ${PID_FILE}`; do kill -9 $$pid; done; \
        rm ${PID_FILE}; \
	fi;