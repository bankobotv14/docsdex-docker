FROM adoptopenjdk/openjdk11-openj9:alpine AS builder

COPY DocDex .

RUN chmod +x gradlew

RUN ./gradlew app:shadowJar -Dorg.gradle.daemon=false

FROM adoptopenjdk/openjdk11-openj9:alpine

WORKDIR /usr/app

COPY --from=builder app/build/libs/docdex.jar ./

ENTRYPOINT ["java", "-jar", "/usr/app/docdex.jar"]
