(./gradlew assemble) || { echo >&2 "Gradle build failed"; exit 1;}
echo "######################## Gradle Complete ############################" 

npm --prefix ./client install || { echo >&2 "npm install failed"; exit 1;}
echo "######################## npm Install Complete #######################" 

npm --prefix ./client run build || { echo >&2 "npm run build failed"; exit 1; }
echo "######################## npm Build Complete #########################" 

