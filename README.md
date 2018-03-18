# OPA Hub for Docker
This is meant as a starting point for anyone interested in running Oracle Policy Automation in Docker.  There are two configurations:

### Weblogic
This runs two containers from official images.  It installs OPA after the containers have started.  It is useful for testing the OPA installer on Oracle supported deployments (Oracle JRE, Weblogic, and MySQL).  The downside is it is resource hungry, slow to start, and does not create images with OPA pre-installed, so does not fully utilize Docker.  See the `weblogic` directory's README for more information.

### Tomcat
This is a completely unsupported configuration (OpenJDK, Tomcat, and MySQL) but is much faster since it builds streamlined images with OPA pre-installed.  This can be useful for developers who want a local Hub install but with a smaller footprint than a VM.  See the `tomcat` directory's README for more information.

### Next steps
The configurations here are constrained by:
1. Not distributing Oracle binaries
2. Not targeting a specific version of OPA

In the real world, you would combine these two approaches to build a Weblogic image with OPA baked in.  You could build the SQL scripts and EAR for a specific OPA version and build them into new images.