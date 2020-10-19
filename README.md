# Docker-Sonarqube

Full [SonarQube](https://www.sonarqube.org/) environment running on top of Docker and other cool stuff.

## Description

SonarQube is an open-source platform developed by SonarSource for continuous inspection of code quality to perform automatic reviews with static analysis of code to detect bugs, code smells, and security vulnerabilities on 20+ programming languages.

The aim of Docker-Sonarqube is to provide a fully functional SonarQube in a lightweight environment such Docker to ease Sonar learning curve and experiment with a fully fledged setup close to a production system. To make things more close to real, [traefik](https://hub.docker.com/_/traefik) provides a HTTP/HTTPS reverse proxy along with https://traefik.me which provide a  wildcard DNS for any IP address with HTTPS support.

<img src=".img/sonar1.png" alt="Sonar" width="800"/>


### Dependencies

- Docker: www.docker.com

- jq: https://stedolan.github.io/jq  

## Getting Started

- Quickstart
    - git clone
    - make up
    - Go to https://sonar.traefik.me and wait untill SonarQube is up and running.
    - make create_token
    - make code_python
    - Log into https://sonar.traefik.me (admin:admin) and check Sonar results for Python_Sample1 project.


## Authors

Phillip Bailey - www.bailey.st
