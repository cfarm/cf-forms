#!/bin/sh

# Set script to exit on any errors.
set -e
# Note: You must run the script with `./setup.sh`.
# If you run with `source setup.sh` or `. setup.sh`,
# and the script encounters an error,
# the whole terminal window will be forcibly closed.

# Initialize project dependency directories.
init() {
  NODE_DIR=node_modules
  BOWER_DIR=bower_components

  if [ -f .bowerrc ]; then
    # Get the "directory" line from .bowerrc
    BOWER_DIR=$(grep "directory" .bowerrc | cut -d '"' -f 4)
  fi

  echo 'npm components directory:' $NODE_DIR
  echo 'Bower components directory:' $BOWER_DIR
}

# Clean project dependencies.
clean() {
  # If the node and Bower directories already exist,
  # clear them so we know we're working with a clean
  # slate of the dependencies listed in package.json
  # and bower.json.
  if [ -d $NODE_DIR ] || [ -d $BOWER_DIR ]; then
    echo 'Removing project dependency directories...'
    rm -rf $NODE_DIR
    rm -rf $BOWER_DIR
  fi

  echo 'Project dependencies have been removed.'
}

# Install project dependencies.
install() {
  echo 'Installing project dependencies...'
  npm install
  bower install --config.interactive=false
}

# Run tasks to build the project for distribution.
build() {
  echo 'Building project...'
  grunt
}

init
clean
install
build