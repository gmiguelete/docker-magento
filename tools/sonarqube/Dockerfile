FROM sonarqube

RUN apt-get update && apt-get install -y unzip

# Install SonarQube Scanner
RUN curl -fSL https://sonarsource.bintray.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-3.0.3.778-linux.zip -o /tmp/sonarqube-scanner.zip && \
    unzip /tmp/sonarqube-scanner.zip -d /usr/local/bin/ && \
    sed -i 's,#sonar.host.url=http://localhost:9000,sonar.host.url=http://localhost:9000,g' /usr/local/bin/sonar-scanner-3.0.3.778-linux/conf/sonar-scanner.properties

ENV PATH="${PATH}:/usr/local/bin/sonar-scanner-3.0.3.778-linux/bin"
