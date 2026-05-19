# Stage 1: Build the Java Application inside Docker
FROM gradle:6.9-jdk8 AS builder
COPY . /home/gradle/project
WORKDIR /home/gradle/project
RUN gradle build --no-daemon

# Stage 2: Run the application in a lightweight image
FROM eclipse-temurin:8-jre-alpine
WORKDIR /usr/app
# هنا التعديل الصح للمسار اللي طلع فيه الـ Jar فعلياً
COPY --from=builder /home/gradle/project/build/libs/*.jar /usr/app/my-app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "my-app.jar"]
