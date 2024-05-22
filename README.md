# Jenkins Docker Image with PowerShell and VMware PowerCLI

This README provides detailed instructions on building and running a custom Jenkins Docker image that includes PowerShell and VMware PowerCLI, along with a set of Jenkins plugins.

## Dockerfile
```Dockerfile
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

```

2. Place the `powershell_7.4.2-1.deb_amd64.deb` file in the cloned directory. ( Or any other version )

3. Build the Docker image:
    ```bash
    docker build -t custom-jenkins:latest .
    ```

## Run the Docker Container

After building the Docker image, you can run a container using the following command:

```bash
docker run -d -p 8080:8080 --name custom-jenkins custom-jenkins:latest
```

# Included Jenkins Plugins
Copy wanted plugins to plugins.txt
The following plugins are included in the Docker image:

- `ansible`: Integrates Ansible with Jenkins for configuration management.
- `ansicolor`: Provides ANSI coloring in the Jenkins console output.
- `antisamy-markup-formatter`: Prevents XSS vulnerabilities by sanitizing HTML input.
- `apache-httpcomponents-client-4-api`: Provides the Apache HttpComponents Client 4.x API for Jenkins plugins.
- `audit-trail`: Tracks user actions in Jenkins for audit purposes.
- `authentication-tokens`: Manages authentication tokens for Jenkins.
- `authorize-project`: Authorizes project-specific actions in Jenkins.
- `blueocean`: Provides a modern, user-friendly UI for Jenkins.
- `bouncycastle-api`: Provides the Bouncy Castle API for Jenkins plugins.
- `branch-api`: Supports multi-branch projects in Jenkins.
- `build-monitor-plugin`: Displays the status of selected Jenkins jobs.
- `build-timeout`: Allows setting build timeouts for Jenkins jobs.
- `build-with-parameters`: Enables running builds with parameters via the UI.
- `calendar-view`: Adds a calendar view for Jenkins jobs.
- `cloudbees-disk-usage-simple`: Monitors disk usage of Jenkins jobs.
- `cloudbees-folder`: Allows organizing Jenkins jobs into folders.
- `command-launcher`: Allows executing commands on remote nodes.
- `configuration-as-code`: Enables configuration of Jenkins via YAML files.
- `credentials`: Manages credentials for Jenkins jobs.
- `credentials-binding`: Binds credentials to environment variables for Jenkins jobs.
- `cron_column`: Adds a column displaying cron triggers to the Jenkins view.
- `dashboard-view`: Provides a dashboard-style view for Jenkins jobs.
- `display-console-output`: Displays console output in the Jenkins job view.
- `display-url-api`: Generates URLs for Jenkins objects.
- `docker-commons`: Provides common Docker functionalities for Jenkins.
- `docker-plugin`: Integrates Docker with Jenkins for build and deployment.
- `docker-workflow`: Adds Docker support to Jenkins pipelines.
- `dropdown-viewstabbar-plugin`: Enhances the Jenkins UI with dropdown tabs.
- `durable-task`: Supports durable tasks that can survive Jenkins restarts.
- `email-ext`: Extends Jenkins email notification capabilities.
- `export-params`: Exports Jenkins build parameters.
- `extra-columns`: Adds extra columns to the Jenkins job view.
- `filesystem-list-parameter-plugin`: Provides file system-based parameter support.
- `fstrigger`: Triggers Jenkins jobs based on file system changes.
- `generic-webhook-trigger`: Triggers Jenkins jobs via webhooks.
- `git`: Provides Git support for Jenkins.
- `git-client`: Supports Git client operations for Jenkins.
- `github`: Integrates GitHub with Jenkins.
- `github-api`: Provides the GitHub API for Jenkins plugins.
- `github-branch-source`: Supports multi-branch projects with GitHub in Jenkins.
- `gitlab-plugin`: Integrates GitLab with Jenkins.
- `git-server`: Provides Git server support for Jenkins.
- `gradle`: Adds Gradle build support to Jenkins.
- `jackson2-api`: Provides the Jackson 2 API for Jenkins plugins.
- `javax-mail-api`: Provides the JavaMail API for Jenkins plugins.
- `jaxb`: Provides the JAXB API for Jenkins plugins.
- `jdk-tool`: Manages JDK installations for Jenkins.
- `jobConfigHistory`: Tracks changes to Jenkins job configurations.
- `jsch`: Provides the JSch library for Jenkins plugins.
- `junit`: Adds JUnit support for Jenkins.
- `kubernetes`: Integrates Kubernetes with Jenkins for container orchestration.
- `ldap`: Provides LDAP authentication support for Jenkins.
- `log-parser`: Parses Jenkins build logs.
- `mailer`: Provides email notification support for Jenkins.
- `managed-scripts`: Manages script files in Jenkins.
- `mapdb-api`: Provides the MapDB API for Jenkins plugins.
- `matrix-auth`: Provides matrix-based security for Jenkins.
- `matrix-project`: Adds support for matrix-based projects in Jenkins.
- `metrics`: Adds monitoring and metrics capabilities to Jenkins.
- `oic-auth`: Provides OpenID Connect authentication for Jenkins.
- `opentelemetry`: Integrates OpenTelemetry for observability in Jenkins.
- `pam-auth`: Provides PAM authentication support for Jenkins.
- `parameterized-scheduler`: Adds parameterized scheduling support to Jenkins.
- `parameterized-trigger`: Triggers builds with parameters in Jenkins.
- `parameter-separator`: Adds parameter separation support in Jenkins.
- `pipeline-build-step`: Adds pipeline build step support to Jenkins.
- `pipeline-github-lib`: Provides GitHub library support for Jenkins pipelines.
- `pipeline-graph-analysis`: Adds pipeline graph analysis support to Jenkins.
- `pipeline-groovy-lib`: Provides Groovy library support for Jenkins pipelines.
- `pipeline-input-step`: Adds input step support to Jenkins pipelines.
- `pipeline-milestone-step`: Adds milestone step support to Jenkins pipelines.
- `pipeline-model-api`: Provides the pipeline model API for Jenkins.
- `pipeline-model-definition`: Adds pipeline model definition support to Jenkins.
- `pipeline-model-extensions`: Provides pipeline model extensions for Jenkins.
- `pipeline-rest-api`: Adds REST API support for Jenkins pipelines.
- `pipeline-stage-step`: Adds stage step support to Jenkins pipelines.
- `pipeline-stage-tags-metadata`: Provides stage tags metadata support for Jenkins pipelines.
- `pipeline-stage-view`: Adds stage view support to Jenkins pipelines.
- `plain-credentials`: Provides plain text credentials support for Jenkins.
- `powershell`: Adds PowerShell support for Jenkins.
- `prometheus`: Integrates Prometheus monitoring with Jenkins.
- `publish-over-cifs`: Provides CIFS publish support for Jenkins.
- `rebuild`: Allows rebuilding Jenkins jobs.
- `resource-disposer`: Manages disposable resources in


