#!/bin/bash

npm --prefix ./client run lint

./gradlew test || { echo "NUnit tests on server failed"; exit 1; }
./gradlew pmdMain || { echo "There are static issues with the main code!";  exit 1;}
./gradlew pmdTest || { echo "There are static issues with the test code!";  exit 1; }
./gradlew checkstyleMain || { echo "Style issues in main code"; }
./gradlew checkstyleTest || { echo "Style issues in test code"; }
