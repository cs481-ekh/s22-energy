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
rulem "[ gradle test ]" '-'
rule '='
./gradlew test || { rulem "NUnit tests on server failed" '!'; exit 1; }
./gradlew pmdMain || { rulem "There are static issues with the main code!" '!';  exit 1; }
./gradlew pmdTest || { rulem "There are static issues with the test code!" '!';  exit 1; }
./gradlew checkstyleMain || { rulem "Style issues in main code" '!'; }
./gradlew checkstyleTest || { rulem "Style issues in test code" '!'; }
rulem "[ gradle test complete ]" '#'

# run npm tests
rule '='
rulem "[ npm test ]" '-'
rule '='
npm --prefix ./client test --silent -- --watchAll=false || { rulem "npm test failed" '!'; exit 1; }
npm --prefix ./client run lint || { rulem "Linter failed" '!'; exit 1; }
rulem "[ npm test complete ]" '#'
