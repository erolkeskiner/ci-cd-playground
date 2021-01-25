node('master'){
    deleteDir()
    checkout scm
    String dockerTag = ""
    stage('Init'){
        sh "make clean-venv"
        sh "make install"
        sh "source venv/bin/activate"
        def targetVersionJsonData
        try{
            targetVersionJsonData = readJSON file: "app/target-version.json"
          } catch (Exception e) {
            error("Cannot read app/target-version.json file.\nError:\n${e}")
          }
        String version = ""
        if(!env.TAG_NAME){
            println(env.TAG_NAME)
            version = targetVersionJsonData["target-version"]
        } else if (env.BRANCH_NAME.equals("main")){
            println(env.BRANCH_NAME)
            version = "${targetVersionJsonData["target-version"]}-rc-${env.BUILD_NUMBER}"
        } else {
            println(env.BRANCH_NAME)
            version = "${targetVersionJsonData["target-version"]}-dev-${env.BUILD_NUMBER}"
        }
        println version
        targetVersionJsonData["target-version"] = version
        writeJSON(file: 'target-version.json', json: targetVersionJsonData)
        sh "cat app/target-version.json"

    }
    stage('Build'){
        sh "make build"
    }
    stage('Test'){
        sh "make lint-all"
        sh "make test"
    }
    stage('Test Report'){
        sh "make coverage-report"
        cobertura autoUpdateHealth: false, autoUpdateStability: false, coberturaReportFile: 'app/coverage.xml', conditionalCoverageTargets: '70, 0, 0', failUnhealthy: false, failUnstable: false, lineCoverageTargets: '80, 0, 0', maxNumberOfBuilds: 0, methodCoverageTargets: '80, 0, 0', onlyStable: false, sourceEncoding: 'ASCII', zoomCoverageChart: false
    }
    stage('Build Docker Image'){
        sh "make docker-build -e DOCKER_TAG=erolkeskiner/basic-web-app:0.1.0-dev PORT=8000"
    }

}