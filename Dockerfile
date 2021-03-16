FROM openjdk:8

RUN apt-get update && \
    apt-get install build-essential maven default-jdk cowsay netcat -y && \
    update-alternatives --config javac && \
    curl https://cdn.shiftleft.io/download/sl-latest-linux-x64.tar.gz | tar xvz -C /usr/local/bin
ENV SHIFTLEFT_ACCESS_TOKEN     
WORKDIR /vulnado/src
COPY . /vulnado/src

ARG TARGET=/vulnado/target
#CMD ["mvn", "spring-boot:run"]
RUN mvn --batch-mode clean package
COPY --from=build ${TARGET}/vulnado-0.0.1-SNAPSHOT.jar
RUN  /usr/local/bin/sl analyze --wait --app vulnado-0.0.1-SNAPSHOT.jar --java ${TARGET}/vulnado-0.0.1-SNAPSHOT.jar

