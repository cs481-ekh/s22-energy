#!/bin/bash

# build the front end and come back
cd client; npm install; cd ..

# build the back end and come back
cd server; gradle build; cd ..

# start the frontend and backend together using npm's concurrently
concurrently "cd server; gradle run --console=plain" "cd client; npm start" 
