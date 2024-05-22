FROM jenkins/jenkins:lts
USER root

WORKDIR /tmp

COPY powershell_7.4.2-1.deb_amd64.deb .

RUN apt-get update && \
    apt-get install -y wget libicu-dev && \
    dpkg -i powershell_7.4.2-1.deb_amd64.deb

RUN pwsh -Command "Install-Module -Name VMware.PowerCLI -Force -AllowClobber -Scope AllUsers"

USER jenkins

COPY plugins.txt /usr/share/jenkins/ref/

RUN git config --global http.sslVerify false

RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt

RUN jenkins-plugin-cli --plugins kubernetes:3842.v7ff395ed0cf3

RUN rm -rf /usr/share/jenkins/ref/plugins.txt
