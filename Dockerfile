FROM openjdk:8

RUN apt-get update && \
    apt-get install build-essential maven default-jdk cowsay netcat -y && \
    update-alternatives --config javac && \
    curl https://cdn.shiftleft.io/download/sl > ${GITHUB_WORKSPACE}/sl && chmod a+rx ${GITHUB_WORKSPACE}/sl
COPY . .

CMD ["mvn", "spring-boot:run"]
RUN  ${GITHUB_WORKSPACE}/sl analyze --wait --app vulnado --tag branch=${{ github.head_ref }} --java .
