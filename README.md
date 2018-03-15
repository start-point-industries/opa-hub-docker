# OPA Hub for Docker

### Why?
This is meant as a starting point for anyone interested in running Oracle Policy Automation in Docker.  This configuration uses two images, one for a MySQL database and the other a Weblogic server.  It then creates a container from each image and then installs OPA.  This makes for an easy way to test new versions of OPA with Docker, however it is not the best Docker solution for actually running OPA.  To take this a step further, you would want to create a docker image with a particular version of OPA already installed, so that you could spin up containers with OPA pre-installed (maybe a project for another day).

### Instructions
This configuration has been tested on Windows 10 and macOS 10.13.
1. Clone this repo
1. Install [Docker](https://www.docker.com/community-edition#/download)
1. Sign up for Oracle Container Registry (https://container-registry.oracle.com)
1. Agree to the Weblogic Image Terms and Restrictions (Middleware / Weblogic / Continue)
1. Log in to Oracle Container Registry through Docker `docker login container-registry.oracle.com`
1. Download [OPA Server 12.2.10](http://www.oracle.com/technetwork/apps-tech/policy-automation/downloads/index.html)
1. Copy the contents of the `opa` directory in the downloaded zip into `opa-hub-docker/opa`
1. Run the provided `start` script on the command line (this will take some time the first run since Docker has to download the MySQL and Weblogic images which are massive)
1. Access your new hub at http://localhost:7001/dev/opa-hub (admin/<password can be found in the command line output>)