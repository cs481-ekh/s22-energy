##[EnergyDB Repository Link](https://github.com/cs481-ekh/s22-energy/actions/workflows/github-actions.yml/badge.svg)

# Building and Deploying Docker 
    Install Docker on your local system
[Docker install](https://docs.docker.com/get-docker/)

```bash
$ docker build -t frontend_and_backend .
$ docker-compose -f docker-compose.yml up
```

Go to following URL to see application running:
    
[API map](http://localhost:3000/)

Got to following URL to update database

[Database](http://locahost:8080/)

![example workflow](https://github.com/cs481-ekh/s22-energy/actions/workflows/github-actions.yml/badge.svg)

# Build Instructions
### Software Requirements
<p>
In order to run this application you must have this software installed:
</p>

- JDK 17+ (Make sure your JDK is greater than 17 or the project wont run)
- Node Package Manager/NodeJS 12+ (Install latest NodeJS for ease of use)

<p>
If you have both of these dependencies installed you are safe to run the build.sh file in the top level directory
</p>

```
 $ chmod +x build.sh 
 $ ./build.sh
 ```
### Running the Application

<p>In order to actually run the application we need to set up the environment. This requires two environment files to be created. One for the client and one for the server. You can run these two commands to create the env files (from the top level directory)
</p>

```
$ touch client/.env
$ touch server/src/main/resources/application.properties
```

Now we need to add information to both of these files

Open up client/.env file and add these lines and fill in the information appropriately
**Items in () will need to be replaced with sensitive login information
specific to your own setup**

```
REACT_APP_API_USER = (endpoint user here should match application.properties spring.security.user)
REACT_APP_API_PASSWORD = (endpoint password here should match application.properties spring.security.password)
REACT_APP_API_KEY= (Bing maps api key here)
REACT_APP_AUTH0_DOMAIN= dev-4wcyhweh.us.auth0.com
REACT_APP_AUTH0_CLIENT_ID= (Auth 0 client id here)
REACT_APP_AUTH0_CALLBACK_URL=http://localhost:3000/admin
```

Next open up the application.properties file, add these entries

```
spring.energydb.url=jdbc:postgresql://dbhost here):(dbPort)/(database name here)?sslmode=require
spring.energydb.username=(db login here)
spring.energydb.password=(db password here)
spring.energydb.driver=org.postgresql.Driver

spring.security.user.name=(endpoint user here should match REACT_APP_API_USER key)
spring.security.user.password=(endpoint password here should match REACT_APP_API_PASSWORD key)
server.port=8000

hibernate.dialect=org.hibernate.dialect.PostgreSQLDialect
hibernate.jdbc.batch_size=25
hibernate.show_sql=false
hibernate.hbm2ddl.auto=validate
hibernate.cache.use_second_level_cache=false
hibernate.cache.use_query_cache=false

logging.level.application=DEBUG
logging.level.root=WARN

spring.servlet.multipart.file-size-threshold=2KB
spring.servlet.multipart.max-file-size=200MB
spring.servlet.multipart.max-request-size=215MB
file.upload-dir=uploads
```

Now the application should be able to run properly you can start
the server/client concurrently by running the start script located in 
the root directory:

```
$ chmod +x start.sh
$ ./start.sh
```
