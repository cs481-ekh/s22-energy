#!/bin/bash

# print a horizontal ruler with mesage
rulem() {
  if [ $# -eq 0 ]; then
    echo "Usage: rulem <message> [<rule character>]"
    return 1
  fi

  # fill line with ruler characters ($2, default "-"), reset cursor, move 2 cols right, print message
  printf -v _hr "%*s" $(tput cols) &&
    echo "" &&
    echo -en "${_hr// /${2--}}" &&
    echo -e "\r\033[2C$1" &&
    echo ""
}

# run gradle tests
./gradlew test || { echo "NUnit tests on server failed"; exit 1; }
./gradlew pmdMain || { echo "There are static issues with the main code!";  exit 1; }
./gradlew pmdTest || { echo "There are static issues with the test code!";  exit 1; }
./gradlew checkstyleMain || { echo "Style issues in main code"; }
./gradlew checkstyleTest || { echo "Style issues in test code"; }
rulem "gradle test complete" '#'

# run npm tests
npm --prefix ./client install || { rulem "npm install failed" '!' }
npm --prefix ./client test --silent -- --watchAll=false || { rulem "npm test failed" '!' }
rulem "npm test complete" '#'

