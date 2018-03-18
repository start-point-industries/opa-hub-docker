# OPA Hub for Docker (Weblogic)

### Why?
This configuration uses two existing images, one for a MySQL database and the other a Weblogic server.  It then creates a container from each image and THEN installs OPA.  This makes for an easy way to test new versions of the OPA installer in an Oracle supported environment.

### Why not?
This is NOT the best Docker solution for actually running OPA.  To take this a step further, you would want to create a docker image with a particular version of OPA already installed, so that you could spin up containers with OPA pre-installed.  In that situation, you would want to generate the database scripts and place them in a MySQL image BUILD process rather than waiting for the Weblogic container (the MySQL image doesn't have a JRE) to install the database.  The other thing that is not ideal about this configuration is that the Oracle Weblogic image is MASSIVE (1.14 GB).  There are projects out there that reduce this size but of course this would be relying on another unofficial source.

### Software Versions
- Weblogic 12.2.1.3 (container-registry.oracle.com/middleware/weblogic:12.2.1.3 - 1.14 GB)
- MySQL 5.7.21 (mysql:5.7.21 - 374 MB)
- This should work for OPA 12.1+, but has only been tested against 12.2.10.

### Instructions
This configuration has been tested on Windows 10 and macOS 10.13.
1. Clone this repo
1. Install [Docker](https://www.docker.com/community-edition#/download)
1. Sign up for Oracle Container Registry (https://container-registry.oracle.com)
1. Agree to the Weblogic Image Terms and Restrictions (Middleware / Weblogic / Continue)
1. Log in to Oracle Container Registry through Docker `docker login container-registry.oracle.com` using your Oracle login
1. Download [OPA Server 12.2.10](http://www.oracle.com/technetwork/apps-tech/policy-automation/downloads/index.html)
1. Unzip the OPA archive and move the contents of the `opa` directory into `opa-hub-docker/weblogic/opa`
1. Run the provided `run.sh / .bat` script on the command line from this directory `opa-hub-docker\weblogic\` (this may take a long time the first run since Docker has to download the MySQL and Weblogic images)
1. Access your new hub at http://localhost:7001/dev/opa-hub (Note the admin password in the console output)

- `stop.sh` to stop the containers
- `remove.sh` to delete the containers
- `start.sh` to start the containers if you haven't already deleted them
- `run.sh` to install them from scratch again (you have to stop and remove them first)
- To try a different version of OPA, simply replace the `opa` directory, run `remove.sh` and rerun `run.sh`
- Optionally, you can configure the MySQL container to use a Docker volume persisted on the Host machine to avoid losing your data when the container is removed e.g. https://hub.docker.com/_/mysql/ "Where to Store Data"