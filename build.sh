./gradlew build || (echo "Gradle build failed"; exit 1)
echo "######################## Gradle Complete ############################" 

npm --prefix ./client install || (echo "npm install failed"; exit 1)
echo "######################## npm Install Complete #######################" 

npm --prefix ./client run build || (echo "npm run build failed"; exit 1)
echo "######################## npm Build Complete #########################" 

