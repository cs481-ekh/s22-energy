![example workflow](https://github.com/cs481-ekh/s22-energy/actions/workflows/github-actions.yml/badge.svg)

# Building and Deploying Docker 
    Install Docker on your local system
[Docker install](https://docs.docker.com/get-docker/)

<p>The docker-compose will require a .env file in the root directory with the following lines:</p>

```
POSTGRES_USER=(put desired username here)
POSTGRES_PASSWORD=(put desired password here)
POSTGRES_DB=energyDB

# (These environment variables are optional
# You can use them if you need to resolve port 
# conflicts on local machine if you set them to
# a value other than this it may require changes 
# in either application.properties or the clients .env)

# (corresponds to client port)
HOST_PORT=(put desired port here) by default = 3000

# (corresponds to server.port in application.properties)
HOST_PORT_API=(put desired port here) by default = 5000

# (adminer database access port)
HOST_PORT_ADMIN=(put desired port here) by default = 8080

# (Port for postgres to run on in docker)
POSTGRES_PORT=(put desired port here) by default = 5432
```
<p>After the .env file has been created, run these commands from the root directory to start the containerized application:</p>

```bash
$ docker build -t frontend_and_backend .
$ docker-compose -f docker-local.yml up
```

Go to following URL to see application running:
    
[API map](http://localhost:3000/energy)

Got to following URL to update database

[Database](http://locahost:8080/)

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
REACT_APP_API_USER = (api username here should match application.properties username)
REACT_APP_API_PASSWORD = (api password here should match application.properties password)
REACT_APP_API_URL=http://localhost:5000
REACT_APP_API_KEY=(bing maps api key)
REACT_APP_AUTH0_DOMAIN=dev-9t0kfb1u.us.auth0.com
REACT_APP_AUTH0_CLIENT_ID=(auth0 client id here)
REACT_APP_AUTH0_CALLBACK_URL=http://localhost:3000/energy/admin
```

Next open up the application.properties file, add these entries

```
# (NOTE 5432 might be different if you added POSTGRES_PORT to your docker .env file)
# Use this energy db if you are debugging locally in your ide
#spring.energydb.url=jdbc:postgresql://localhost:5432/energyDB

# Use this energy db if you are running front end, back end and postgres in docker.
spring.energydb.url=jdbc:postgresql://energy-postgres:5432/energyDB

#(This value corresponds to POSTGRES_USER in dockers env)
spring.energydb.username=(db login here)

#(This value corresponds to POSTGRES_PASSWORD in dockers env)
spring.energydb.password=(db password here)
spring.energydb.driver=org.postgresql.Driver

spring.security.user.name=(endpoint user here should match REACT_APP_API_USER key)
spring.security.user.password=(endpoint password here should match REACT_APP_API_PASSWORD key)

#(NOTE: THIS VALUE MIGHT CHANGE IF YOU HAVE HOST_PORT_API specified in dockers .env)
server.port=5000

hibernate.dialect=org.hibernate.dialect.PostgreSQLDialect
hibernate.jdbc.batch_size=25
hibernate.show_sql=false
hibernate.hbm2ddl.auto=validate
hibernate.cache.use_second_level_cache=false
hibernate.cache.use_query_cache=false

logging.level.application=DEBUG
logging.level.root=WARN

server.servlet.context-path=/energy/api

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
