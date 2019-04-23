# OPA Hub for Docker (Tomcat)
This builds two images: MySQL + OPA SQL scripts and Tomcat + OPA apps.  **This is in no way a supported method of deploying OPA.**

### Software Versions
- Docker 18.06
- Tomcat 7 with OpenJDK JRE 7 (tomcat:7-jre7-alpine - 145 MB)
- MySQL 5.7.21 (mysql:5.7.21 - 374 MB)
- This has only been tested against OPA 12.2.10 and 12.2.11 (check out the tag specific to your version).

### Instructions
This configuration has been tested on Windows 10 and macOS 10.13.
1. Clone this repo
1. Install [Docker](https://www.docker.com/community-edition#/download)
1. Download OPA Server 12.2.11 from [Oracle Software Delivery Cloud](https://edelivery.oracle.com)
1. Rename the OPA archive `opa.zip`
1. Copy `opa.zip` into the directory opa-hub-docker\tomcat\**opa-mysql-slim**\files
1. Copy `opa.zip` into the directory opa-hub-docker\tomcat\**opa-tomcat-slim**\files
1. Run the provided `build.sh / .bat` script on the command line from this directory (`opa-hub-docker\tomcat\`)
1. Run `run.sh / .bat` to start the containers
1. Access your new hub at http://localhost:8787/opa-hub (admin/Passw0rd)

- `stop` to stop the containers
- `remove` to delete the containers
- `start` to start the containers if you haven't already deleted them
- `run` to install them from scratch again (you have to stop and remove them first)
- To try a different version of OPA, simply replace the two `opa.zip` files, run `remove` and rerun `build` and `run`
- Optionally, you can configure the MySQL container to use a Docker volume persisted on the Host machine to avoid losing your data when the container is removed e.g. https://hub.docker.com/_/mysql/ "Where to Store Data"