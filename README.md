# [Traccar](https://www.traccar.org)

## Overview

Traccar is an open source GPS tracking system. This repository contains Java-based back-end service. It supports more than 200 GPS protocols and more than 2000 models of GPS tracking devices. Traccar can be used with any major SQL database system. It also provides easy to use [REST API](https://www.traccar.org/traccar-api/).

Other parts of Traccar solution include:

- [Traccar web app](https://github.com/traccar/traccar-web)
- [Traccar Manager Android app](https://github.com/traccar/traccar-manager-android)
- [Traccar Manager iOS app](https://github.com/traccar/traccar-manager-ios)

There is also a set of mobile apps that you can use for tracking mobile devices:

- [Traccar Client Android app](https://github.com/traccar/traccar-client-android)
- [Traccar Client iOS app](https://github.com/traccar/traccar-client-ios)

## Features

Some of the available features include:

- Real-time GPS tracking
- Driver behaviour monitoring
- Detailed and summary reports
- Geofencing functionality
- Alarms and notifications
- Account and device management
- Email and SMS support

## Docker Usage

This repository includes Docker support for easy deployment. The container is published to GitHub Container Registry (ghcr.io).

### Prerequisites

- Docker and Docker Compose installed
- PostgreSQL running on the host machine
- Ports 8082 and 5000-5150 available

### Quick Start

1. Create a `docker-compose.yml` file:

```yaml
version: '3.8'

services:
  traccar:
    image: ghcr.io/YOUR_USERNAME/traccar:latest
    container_name: traccar
    ports:
      - "8082:8082"  # Web interface
      - "5000-5150:5000-5150"  # Device communication ports
    volumes:
      - ./media:/app/media  # For storing media files
    environment:
      - JAVA_OPTS=-Xms512m -Xmx2048m
    extra_hosts:
      - "host.docker.internal:host-gateway"  # This allows the container to access the host machine
    restart: unless-stopped
```

2. Create a `debug.xml` file with your PostgreSQL configuration:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE properties SYSTEM 'http://java.sun.com/dtd/properties.dtd'>
<properties>
    <entry key='web.path'>./traccar-web/build</entry>
    <entry key='web.debug'>true</entry>
    <entry key='web.console'>true</entry>
    <entry key='database.driver'>org.postgresql.Driver</entry>
    <entry key='database.url'>jdbc:postgresql://host.docker.internal:5432/credifytraccar</entry>
    <entry key='database.user'>postgres</entry>
    <entry key='database.password'>your_password</entry>
</properties>
```

3. Run the container:

```bash
docker-compose up -d
```

4. Access the web interface at `http://localhost:8082`

### Building Locally

To build the Docker image locally:

```bash
docker build -t traccar .
```

## Build

Please read [build from source documentation](https://www.traccar.org/build/) on the official website.

## Team

- Anton Tananaev ([anton@traccar.org](mailto:anton@traccar.org))
- Andrey Kunitsyn ([andrey@traccar.org](mailto:andrey@traccar.org))

## License

    Apache License, Version 2.0

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
