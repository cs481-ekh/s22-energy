# <span style="color: #FF7700;font-weight: bold;"> Boise State Energy Dashboard </span>

![](../client/src/imgs/Electric.jpg)
    
### <span style="color: #FF9900">Team Energy</span>

```
Aidan Leuck
Jack Carr
Khaled Natouf
Keegan Hanes
Taylor Poulsen
Victor Cerda
```

## <span style="color: #FF9900">Abstract:</span>

Boise State Energy Dashboard is an visual web application developed to allow Boise State University to monitor their energy usage.  There are several universities that currently have energy usage applications.  Our team felt like we could create a solid base for an application that could be used by Boise State to serve as a tool.  Current energy monitoring is based on individual reports pulled from different energy companies and analyzed via spreadsheets. Team Energy wanted to help Boise State move its understanding of energy usage to the next level.

There are various types of energy that are being used at Boise State.  Team Energy wanted to create a visual representation of these different types of energy.  Our web application creates a map based visual representation of Boise State.  It then includes the buildings being used by BSU and creates informative cards.  These cards will display building names and energy usage.  There are parameters that can be adjusted, such as, date range and utility type.  Team Energy also has energy levels based on color, so a high usage of energy could be easily identified.  This application is a great representation of energy throughout Boise State

## <span style="color: #FF9900">Project Description:</span>
In collaboration with our sponsor Brian Emtman, Team Energy offered an idea of creating a Boise State Energy Dashboard.  Our application works on three fronts, a client side visual representation, a backend java infrastructure, and a database storage management.  

The client side allows us to create an accurate map of the BSU campus via a web application.  With this application we added web based pages to handle administrative needs:  login in needs and data uploads requirements.  Using the data uploads our team was then able to visually display buildings and energy usage.  Features also  include energy conversion, date range searches, energy types and color scheme to represent usage levels.  

The database storage is a key piece and allows us to store the information needs of BSU.  Team energy was able to create a schema that allows for a seamless interaction between the client and backend side of the application.  We are now able to identify buildings and their usages based on user request parameters.  

The backend/server side is the piece that ties it all together.  Our server logic allowed for the interaction between the client and the database.  All the needs that the client required were handled by the server logic and turned into valid data points.  These data points were then either used to create visual representations on the map or administrative needs.  The server logic even logged errors, so issues could be easily identified.  

This project is a great starting point for future development of the Boise State Energy dashboard.  


## <span style="color: #FF9900">Building and Deploying Docker</span>
    
    Install Docker on your local system
[Docker install](https://docs.docker.com/get-docker)

<p>The docker-compose will require a .env file in the root directory with the following lines:</p>

```
POSTGRES_USER= (put desired username here)
POSTGRES_PASSWORD= (put desired password here)
POSTGRES_DB=energyDB
HOST_PORT=3000
HOST_PORT_API=5000
HOST_PORT_ADMIN=8080
```
<p>After the .env file has been created, run these commands from the root directory to start the containerized application:</p>

```bash
$ docker-compose -f docker-compose.yml up
```

Go to following URL to see application running:
    
[API map](http://localhost:3000/energy)

Got to following URL to update database

[Database](http://locahost:8080/)

## <span style="color: #FF9900">Build Instructions</span>
### <span style="color: #FF9900">Software Requirements</span>

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
### <span style="color: #FF9900">Running the Application</span>

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
spring.energydb.url=jdbc:postgresql://dbhost here):(dbPort)/(database name here)
spring.energydb.username=(db login here)
spring.energydb.password=(db password here)
spring.energydb.driver=org.postgresql.Driver

spring.security.user.name=(endpoint user here should match REACT_APP_API_USER key)
spring.security.user.password=(endpoint password here should match REACT_APP_API_PASSWORD key)
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
