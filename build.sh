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



rule '='
rulem "[ gradle build ]" '='
rule '='
(./gradlew assemble) || { rulem "Gradle build failed" '!'; exit 1; }
rulem "[ gradle build complete ]" '#'

rule '='
rulem "[ npm build ]" '='
rule '='
npm --prefix ./client install || { rulem "npm install failed" '!'; exit 1; }
npm --prefix ./client run build || { rulem "npm run build failed" '!'; exit 1; }
rulem "[ npm build complete ]" '#'
