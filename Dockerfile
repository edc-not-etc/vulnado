FROM openjdk:8

RUN apt-get update && \
    apt-get install build-essential maven default-jdk cowsay netcat -y && \
    update-alternatives --config javac && \
    curl https://cdn.shiftleft.io/download/sl-latest-linux-x64.tar.gz | tar xvz -C /usr/local/bin
ENV SHIFTLEFT_ACCESS_TOKEN=...
WORKDIR /vulnado/src
COPY . /vulnado/src

#CMD ["mvn", "spring-boot:run"]
RUN mvn --batch-mode clean package
COPY ${WORKDIR}/target/vulnado-0.0.1-SNAPSHOT.jar /vulnado/vulnado-0.0.1-SNAPSHOT.jar
CMD  /usr/local/bin/sl analyze --wait --app vulnado-0.0.1-SNAPSHOT.jar --java /vulnado/vulnado-0.0.1-SNAPSHOT.jar
