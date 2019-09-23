pipeline {
    agent {
        dockerfile {
            additionalBuildArgs '--build-arg UID=$(id -u) --build-arg GID=$(id -g) -t ubuntu:1'
            args '-v $HOME/.m2:/build/.m2:z'
        }
    }
    stages {
        stage('install json-server and newman tools') {
            steps {
                script {
                    try {
                        sh "npm i"
                    }
                    catch(error)
                    {
                        currentBuild.result =  'FAILURE'
                    }
                }
            }
        }
        stage('api-testing poc') {
            steps {
                script {
                    try {
                        sh "npm run json-server:run"
                        sh "npm run newman:run"
                    }
                    catch(error)
                    {
                        currentBuild.result =  'FAILURE'
                    }
                }
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}
