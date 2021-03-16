FROM openjdk:8

RUN apt-get update && \
    apt-get install build-essential maven default-jdk cowsay netcat -y && \
    update-alternatives --config javac && \
    curl https://cdn.shiftleft.io/download/sl-latest-linux-x64.tar.gz | tar xvz -C /usr/local/bin
ENV SHIFTLEFT_ACCESS_TOKEN=...     

COPY . .

#CMD ["mvn", "spring-boot:run"]
CMD ["mvn", "clean package"]

RUN  /usr/local/bin/sl analyze --wait --app vulnado-0.0.1-SNAPSHOT.jar --java ./target/vulnado-0.0.1-SNAPSHOT.jar

