#!/bin/bash

# start the frontend and backend together using npm's concurrently
cd client
npm install
npm run concurrently
