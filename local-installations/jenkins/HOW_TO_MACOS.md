# Install and Configure Jenkins Locally: 

## Using Docker

```bash
docker run -p 8080:8080 -p 50000:50000 -v ~/jenkins_home:/var/jenkins_home jenkins/jenkins:lts
```

This will start the Jenkins server in a few seconds. You can check if it is properly working by visiting [http://localhost:8080/](http://localhost:8080/)

To get the password needed to run the installation process, check the terminal output logs from the `docker run` command above.

Note: The Jenkins Docker container can be run in the background. To do this, refer [here](https://docs.docker.com/language/nodejs/run-containers/#run-in-detached-mode).

## Using Brew
```bash
brew install jenkins-lts
```

### Start as a Service:

```bash
brew services start jenkins-lts
```

This will start the Jenkins server in a few seconds. You can check if it is properly working by visiting [http://localhost:8080/](http://localhost:8080/)

To get the password needed to run the installation process, check the content of the file whose path is shown on the screen when you visit the address mentioned above.

```bash
cat /Users/<user_name>/.jenkins/secrets/initialAdminPassword
```

# Initial configuration
Login with the generated password. 

Since, we can install all extra plugins needed after the initial configuration, select 'Install suggested plugins'.
Plugin installations might take a while.

When all suggested plugins are installed, you'll be asked to create first Admin user. 
Fill the user creation form with related information and click the `Save and Continue` button.

In the next page, `Jenkins URL` must be configured. 
Since this is a local installation, the URL can be configured as `http://localhost:8080/`. 
Click the `Save and Finish` button to finish the initial configuration.  

After the initial configuration steps, you can start using local Jenkins server by clicking the `Start using Jenkins`.

# Plugin Installation

Refer [here](https://linuxtechlab.com/3-methods-to-install-plugins-on-jenkins-server/), for additional plugin installations.

Here is the list of Jenkins plugins installed for this project:

- JSch dependency plugin (jsch): 0.1.55.2
- Workspace Cleanup Plugin (ws-cleanup): 0.38
- Common API for Blue Ocean (blueocean-commons): 1.24.4
- ECharts API Plugin (echarts-api): 4.9.0-3
- Pipeline: Multibranch with defaults (pipeline-multibranch-defaults): 2.1
- Structs Plugin (structs): 1.20
- Server Sent Events (SSE) Gateway Plugin (sse-gateway): 1.24
- Build Pipeline Plugin (build-pipeline-plugin): 1.5.8
- Conditional BuildStep (conditional-buildstep): 1.4.1
- Apache HttpComponents Client 4.x API Plugin (apache-httpcomponents-client-4-api): 4.5.13-1.0
- Cobertura Plugin (cobertura): 1.16
- Parameterized Trigger plugin (parameterized-trigger): 2.39
- Pipeline: Declarative Extension Points API (pipeline-model-extensions): 1.7.2
- GitHub Integration Plugin (github-pullrequest): 0.2.8
- Kubernetes plugin (kubernetes): 1.28.7
- Pipeline (workflow-aggregator): 2.6
- Mailer Plugin (mailer): 1.32.1
- Git plugin (git): 4.5.2
- Handy Uri Templates 2.x API Plugin (handy-uri-templates-2-api): 2.1.8-1.0
- Bootstrap 4 API Plugin (bootstrap4-api): 4.5.3-1
- JQuery3 API Plugin (jquery3-api): 3.5.1-2
- Command Agent Launcher Plugin (command-launcher): 1.5
- Python Plugin (python): 1.3
- Pipeline: API (workflow-api): 2.41
- Pipeline: Job (workflow-job): 2.40
- SSH Credentials Plugin (ssh-credentials): 1.18.1
- Authentication Tokens API Plugin (authentication-tokens): 1.4
- REST Implementation for Blue Ocean (blueocean-rest-impl): 1.24.4
- GitHub Branch Source Plugin (github-branch-source): 2.9.3
- HTML Publisher plugin (htmlpublisher): 1.25
- Javadoc Plugin (javadoc): 1.6
- Pipeline: Shared Groovy Libraries (workflow-cps-global-lib): 2.17
- Web for Blue Ocean (blueocean-web): 1.24.4
- Jackson 2 API Plugin (jackson2-api): 2.12.1
- Email Extension Template Plugin (emailext-template): 1.2
- SSH Build Agents plugin (ssh-slaves): 1.31.5
- Kubernetes Client API Plugin (kubernetes-client-api): 4.11.1
- Docker Pipeline (docker-workflow): 1.25
- Pipeline: Stage Tags Metadata (pipeline-stage-tags-metadata): 1.7.2
- Pipeline SCM API for Blue Ocean (blueocean-pipeline-scm-api): 1.24.4
- Pipeline: Milestone Step (pipeline-milestone-step): 1.3.1
- Credentials Plugin (credentials): 2.3.14
- Bitbucket Branch Source Plugin (cloudbees-bitbucket-branch-source): 2.9.7
- jQuery plugin (jquery): 1.12.4-1
- GitHub plugin (github): 1.32.0
- Lockable Resources plugin (lockable-resources): 2.10
- JavaScript GUI Lib: jQuery bundles (jQuery and jQuery UI) plugin (jquery-detached): 1.2.1
- Personalization for Blue Ocean (blueocean-personalization): 1.24.4
- Pipeline: SCM Step (workflow-scm-step): 2.11
- Matrix Authorization Strategy Plugin (matrix-auth): 2.6.5
- Matrix Project Plugin (matrix-project): 1.18
- Pipeline: Stage Step (pipeline-stage-step): 2.5
- Pipeline: Build Step (pipeline-build-step): 2.13
- OWASP Markup Formatter Plugin (antisamy-markup-formatter): 2.1
- Pipeline: Input Step (pipeline-input-step): 2.12
- Ant Plugin (ant): 1.11
- bouncycastle API Plugin (bouncycastle-api): 2.18
- Dashboard View (dashboard-view): 2.14
- Checks API plugin (checks-api): 1.2.0
- Pipeline timeline (pipeline-timeline): 1.0.3
- JavaScript GUI Lib: Handlebars bundle plugin (handlebars): 1.1.1
- Blue Ocean (blueocean): 1.24.4
- Pipeline: GitHub Groovy Libraries (pipeline-github-lib): 1.0
- Variant Plugin (variant): 1.4
- JavaScript GUI Lib: Moment.js bundle plugin (momentjs): 1.1.1
- JWT for Blue Ocean (blueocean-jwt): 1.24.4
- Plain Credentials Plugin (plain-credentials): 1.7
- Docker Commons Plugin (docker-commons): 1.17
- Configuration as Code Plugin (configuration-as-code): 1.46
- Git client plugin (git-client): 3.6.0
- Timestamper (timestamper): 1.11.8
- Gradle Plugin (gradle): 1.36
- Pipeline: REST API Plugin (pipeline-rest-api): 2.19
- Pipeline: Basic Steps (workflow-basic-steps): 2.23
- GitHub API Plugin (github-api): 1.122
- i18n for Blue Ocean (blueocean-i18n): 1.24.4
- LDAP Plugin (ldap): 1.26
- Events API for Blue Ocean (blueocean-events): 1.24.4
- JAXB plugin (jaxb): 2.3.0.1
- Blue Ocean Core JS (blueocean-core-js): 1.24.4
- Maven Integration plugin (maven-plugin): 3.8
- Config API for Blue Ocean (blueocean-config): 1.24.4
- GitHub Pipeline for Blue Ocean (blueocean-github-pipeline): 1.24.4
- Kubernetes Credentials Plugin (kubernetes-credentials): 0.8.0
- Embeddable Build Status Plugin (embeddable-build-status): 2.0.3
- Font Awesome API Plugin (font-awesome-api): 5.15.1-1
- Credentials Binding Plugin (credentials-binding): 1.24
- Pipeline: Declarative (pipeline-model-definition): 1.7.2
- Config File Provider Plugin (config-file-provider): 3.7.0
- Pipeline: Stage View Plugin (pipeline-stage-view): 2.19
- Token Macro Plugin (token-macro): 2.13
- Display URL for Blue Ocean (blueocean-display-url): 2.4.0
- Pipeline: Multibranch (workflow-multibranch): 2.22
- Script Security Plugin (script-security): 1.75
- GIT server Plugin (git-server): 1.9
- Snakeyaml API Plugin (snakeyaml-api): 1.27.0
- Pipeline: Step API (workflow-step-api): 2.23
- Run Condition Plugin (run-condition): 1.5
- Rebuilder (rebuild): 1.31
- OkHttp Plugin (okhttp-api): 3.14.9
- Icon Shim Plugin (icon-shim): 2.0.3
- Pipeline Graph Analysis Plugin (pipeline-graph-analysis): 1.10
- Build Name and Description Setter (build-name-setter): 2.1.0
- Metrics Plugin (metrics): 4.0.2.7
- Git Pipeline for Blue Ocean (blueocean-git-pipeline): 1.24.4
- Pipeline: Model API (pipeline-model-api): 1.7.2
- Plugin Utilities API Plugin (plugin-util-api): 1.6.1
- Design Language (jenkins-design-language): 1.24.4
- Pipeline: Groovy (workflow-cps): 2.87
- Popper.js API Plugin (popper-api): 1.16.0-7
- Autofavorite for Blue Ocean (blueocean-autofavorite): 1.2.4
- GitHub Status Wrapper Plugin (pipeline-gitstatuswrapper): 1.2.0
- Pipeline: Nodes and Processes (workflow-durable-task-step): 2.37
- Email Extension Plugin (email-ext): 2.81
- Trilead API Plugin (trilead-api): 1.0.13
- Branch API Plugin (branch-api): 2.6.2
- Oracle Java SE Development Kit Installer Plugin (jdk-tool): 1.4
- Folders Plugin (cloudbees-folder): 6.15
- Blue Ocean Pipeline Editor (blueocean-pipeline-editor): 1.24.4
- Dashboard for Blue Ocean (blueocean-dashboard): 1.24.4
- Durable Task Plugin (durable-task): 1.35
- JUnit Plugin (junit): 1.48
- PAM Authentication plugin (pam-auth): 1.6
- Pub-Sub "light" Bus (pubsub-light): 1.13
- SCM API Plugin (scm-api): 2.6.4
- Pipeline implementation for Blue Ocean (blueocean-pipeline-api-impl): 1.24.4
- JavaScript GUI Lib: ACE Editor bundle plugin (ace-editor): 1.1
- Code Coverage API Plugin (code-coverage-api): 1.2.0
- Display URL API (display-url-api): 2.3.4
- Pipeline: Supporting APIs (workflow-support): 3.7
- Resource Disposer Plugin (resource-disposer): 0.14
- REST API for Blue Ocean (blueocean-rest): 1.24.4
- Terraform Plugin (terraform): 1.0.10
- Build Timeout (build-timeout): 1.20
- Favorite (favorite): 2.3.2
- Bitbucket Pipeline for Blue Ocean (blueocean-bitbucket-pipeline): 1.24.4
- Git Parameter Plug-In (git-parameter): 0.9.13

Note: Some plugins in the list may not have been used in this project.


# GitHub Integration

[This](https://medium.com/@shreyaklexheal/integrate-jenkins-with-github-private-repo-8fb335494f7e#:~:text=Jenkins%20configuration%20to%20access%20private,Global%20credentials%20%2D%3E%20Add%20credentials.&text=Give%20username%20as%20Jenkins%20or,keys%20here%2C%20click%20on%20okay.) can be referred to establish integration between Jenkins and a GitHub repository.