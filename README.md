# Docker Logstation Image

## Preparation

### General
Logstation main folder - `/opt/logstation` and it is set as WORKDIR.
Logstation main config file - `/opt/logstation/logstation.conf` and it exists with default content.
Logstation log dir - `/opt/logstation/logs` - empty by defaullt. You should change your own config regarding this path or just mount your logs wherever you want.

### docker-compose file
Here is an example using docker-compose.yml:

```yml
version: "2"
services:
  logstation:
    image: saintzyo/logstation:0.3.11
    ports:
      - "8884:8884"
    volumes:
      - ./logstation.conf:/opt/logstation/logstation.conf
      - /var/logs/nginx:/opt/logstation/logs
```

### logstation.conf file
When container starts it generates default `logstation.conf` file. You should override it with your own parameters like in the example below:

```json
logstation {
    # Unix example of setting up logs
    logs=["/opt/logstation/logs/access.log","/opt/logstation/logs/error.log"]

    # Setup your syntax below
    # <some-name>=[<RGB_HEX>,<regex-for-line-matching>]
    # matching gives priority to the top most
    syntax {
        # red
        error=["#FF1F1F",".*ERROR.*"]
        # yellow
        warn=["#F2FF00",".*WARN.*"]
        # green
        info=["#00FF2F",".*INFO.*"]
        # blue
        debug=["#4F9BFF",".*DEBUG.*"]
        # cyan
        trace=["#4FFFF6",".*TRACE.*"]
    }

    # Web Server Port
    #    The port used to connect to the LogStation
    webServerPort=8884

    # Number of lines to display per log file
    #    any logs over this will truncate the oldest lines from the page
    maxLogLinesPerLog=1500

    # Number of messages to buffer on server
    #    These will be sent to any new connections so they have some history of logs
    #    bufferLength is multiplied by number of logs, and buffered on best effort for each log
    bufferLength=10

    # Unique name for logstation instance
    #    This name will be prepended to the browser tab
    #    Can be useful when connecting to multiple logstations
    logStationName="Logstation"
}
```