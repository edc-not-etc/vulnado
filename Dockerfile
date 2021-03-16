FROM openjdk:8

RUN apt-get update && \
    apt-get install build-essential maven default-jdk cowsay netcat -y && \
    update-alternatives --config javac && \
    curl https://cdn.shiftleft.io/download/sl > sl && chmod a+rx sl
COPY . .

RUN  sl analyze --wait --app vulnado --java .
CMD ["mvn", "spring-boot:run"]

