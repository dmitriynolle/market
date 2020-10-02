FROM openjdk:12-alpine
COPY target/geek-market-winter*.jar /MarketWinter.jar
CMD ["java", "-jar", "/MarketWinter.jar"]