# المرحلة الأولى: بناء مشروع الجافا جوه دوكر نفسه
FROM gradle:6.9-jdk8 AS builder
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle build --no-daemon

# المرحلة الثانية: تشغيل الأبلكيشن في إيمدج خفيفة
FROM eclipse-temurin:8-jre-alpine
WORKDIR /usr/app
COPY --from=builder /home/gradle/src/build/libs/my-app-1.0-SNAPSHOT.jar /usr/app/
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "my-app-1.0-SNAPSHOT.jar"]
