node('master'){
    deleteDir()
    checkout scm
    sh 'ls -al'
    stage('Init'){
        sh "make clean-venv"
        sh "make install"
        sh "source venv/bin/activate"
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