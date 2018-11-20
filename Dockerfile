FROM  openjdk:9-jre-slim

LABEL maintainer="saintzyo@gmail.com"
LABEL org.label-schema.build-date="$(date)"
LABEL org.label-schema.vcs-url="https://github.com/saintzyo/logstation-docker"
LABEL org.label-schema.vcs-tool-url="https://github.com/jdrews/logstation"

ARG VERSION=0.3.11

RUN apt-get update  -y &&  apt-get install -y wget && apt-get clean

RUN mkdir -p /opt/logstation /opt/logstation/conf /opt/logstation/logs

WORKDIR /opt/logstation

RUN wget https://github.com/jdrews/logstation/releases/download/${VERSION}/logstation-${VERSION}.jar -O logstation.jar
RUN java -jar logstation.jar

VOLUME [ "/opt/logstation" ]
EXPOSE 8884

CMD [ "java", "-jar", "logstation.jar" ]
