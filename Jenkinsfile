node('master'){
    deleteDir()
    checkout scm
    String version = ""
    String environment = ""
    stage('Initial Setup'){
        sh "make clean-venv"
        sh "make install"
        sh "source venv/bin/activate"
        def targetVersionJsonData
        try{
            targetVersionJsonData = readJSON file: "app/target-version.json"
          } catch (Exception e) {
            error("Cannot read app/target-version.json file.\nError:\n${e}")
          }
        if(env.TAG_NAME){
            version = targetVersionJsonData["target-version"]
            environment = "prod"
        } else if (env.BRANCH_NAME.equals("main")){
            version = "${targetVersionJsonData["target-version"]}-rc-${env.BUILD_NUMBER}"
            environment = "rc"
        } else {
            version = "${targetVersionJsonData["target-version"]}-dev-${env.BUILD_NUMBER}"
            environment = "dev"
        }
        targetVersionJsonData["target-version"] = version
        writeJSON(file: 'app/target-version.json', json: targetVersionJsonData)
    }
    stage('Test'){
        sh "make lint-all"
        recordIssues(tools: [pyLint(pattern: 'app/pylint.log')])
        sh "make test"
    }
    stage('Test Report'){
        sh "make coverage-report"
        cobertura autoUpdateHealth: false, autoUpdateStability: false, coberturaReportFile: 'app/coverage.xml', conditionalCoverageTargets: '70, 0, 0', failUnhealthy: false, failUnstable: false, lineCoverageTargets: '80, 0, 0', maxNumberOfBuilds: 0, methodCoverageTargets: '80, 0, 0', onlyStable: false, sourceEncoding: 'ASCII', zoomCoverageChart: false
    }
    stage('Build'){
        sh "make build"
    }
    stage('Build Docker Image'){
        sh "make docker-build -e DOCKER_TAG=erolkeskiner/basic-web-app:${version} PORT=8000"
    }
    stage('Publish Docker Image'){
        /* withCredentials([usernamePassword(credentialsId: 'f946777f-7915-4e23-a86a-1af0bc0068d4', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
            sh "docker login -u $USERNAME -p $PASSWORD"
        } */
        withDockerRegistry(credentialsId: 'f946777f-7915-4e23-a86a-1af0bc0068d4', url: 'https://index.docker.io/v1/') {
            sh "docker push erolkeskiner/basic-web-app:${version}"
        }
    }
    stage("Deploy to ${environment}"){
    dir("deploy/terraform"){
            sh "terraform init"
            sh "terraform import kubernetes_namespace.release-namespace ${environment}"
            sh "terraform import helm_release.local ${environment}/flask-app"
            sh "terraform plan --var-file=${environment}.tfvars --var tag=${version}"
            input "Do you want to proceed with the deployment ?"
            sh "terraform apply --var-file=${environment}.tfvars --var tag=${version} --auto-approve"
        }
    }
}