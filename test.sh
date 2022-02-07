#!/bin/bash
./gradlew test || { echo "NUnit tests on server failed"; exit 1; }
./gradlew pmdMain || { echo "There are static issues with the main code!"; }
./gradlew pmdTest || { echo "There are static issues with the test code!";  exit 1; }
./gradlew checkstyleMain || { echo "Style issues in main code"; exit 1; }
./gradlew checkstyleTest || { echo "Style issues in test code"; exit 1; }
