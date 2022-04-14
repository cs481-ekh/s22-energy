FROM ubuntu:20.04
RUN apt update

# Install add-apt-repository
RUN apt -y install software-properties-common

# Install Java 17
RUN add-apt-repository -y ppa:linuxuprising/java
RUN apt install -y openjdk-17-jdk

# Install Node 16 with curl
RUN apt install -y ca-certificates curl
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN apt install -y nodejs


# Create working directory
COPY . /app
WORKDIR /app

ENTRYPOINT ["./start.sh"]
