#!/bin/bash

# build the back end
./gradlew build

# build the front end and come back to root
cd client; npm install; cd ..

# start the frontend and backend together using npm's concurrently
concurrently "./gradlew run --console=plain" "cd client; npm start" 
