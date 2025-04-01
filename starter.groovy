pipeline {
    agent any

    environment {
        BUILD_FILE_NAME = 'buildlog.txt'
    }

    stages {
        stage('Build') {
            steps {
                // under always it executes before every other post actions
                // clear the workspace before our work starts
                cleanWs()
                echo 'Building the IaC System...'
                sh '''
                echo ${BUILD_FILE_NAME}
                mkdir -p build
                echo "System: $(uname -a)" >> build/${BUILD_FILE_NAME}
                echo "User: $(whoami)@$(hostname)" >> build/${BUILD_FILE_NAME}
                echo "PATH: ${PATH}" >> build/${BUILD_FILE_NAME}
                echo "Terraform Version: $(terraform version)" >> build/${BUILD_FILE_NAME}
                cat build/${BUILD_FILE_NAME}
                '''
            }
        }
        stage('Test') {
            steps {
                echo 'Testing the IaC setup...'
                sh '''
                test -f build/${BUILD_FILE_NAME}
                grep -i "terraform" build/${BUILD_FILE_NAME}
                grep -i "path" build/${BUILD_FILE_NAME}
                '''
            }
        }
    }

    // post completion tasks of pipeline
    post {
        success {
            // This build step archives specified artifacts into Jenkins
            archiveArtifacts artifacts: 'build/**'
        }
    }
}
