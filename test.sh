#!/bin/bash

# print a horizontal rule
rule() {
  printf -v _hr "%*s" $(tput cols) && echo "${_hr// /${1--}}"
}

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
rule '='
rulem "[ gradle test ]" '='
rule '='
./gradlew test || { echo "NUnit tests on server failed"; exit 1; }
./gradlew pmdMain || { echo "There are static issues with the main code!";  exit 1; }
./gradlew pmdTest || { echo "There are static issues with the test code!";  exit 1; }
./gradlew checkstyleMain || { echo "Style issues in main code"; }
./gradlew checkstyleTest || { echo "Style issues in test code"; }

# run npm tests
rule '='
rulem "[ npm test ]" '='
rule '='
npm --prefix ./client install || { rulem "npm install failed" '!'; exit 1; }
npm --prefix ./client test --silent -- --watchAll=false || { rulem "npm test failed" '!'; exit 1; }

