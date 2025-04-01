pipeline {
    agent any 

    parameters {
        choice(
            name: 'ENVIRONMENT',
            choices: ['dev', 'test', 'stage', 'prod'],
            description: 'Select the appropriate Environment'
        )
        choice(
            name: 'ACTION',
            choices: "format\nvalidate\nplan\napply\ndestroy",
            description: 'Choose a Terraform workflow'
        )
    }
    environment {
        S3_BUCKET = "svcapi-tf-s3"
        AWS_REGION = "us-east-2"
        STATE_FILE_KEY = "${params.ENVIRONMENT}/terraform.tfstate"
        TFVARS_FILE="${params.ENVIRONMENT}.tfvars"
    }
    stages {
        stage ('init') {
            steps {
                sh """
                terraform init -reconfigure \
                    -backend-config="bucket=${S3_BUCKET}" \
                    -backend-config="key=${STATE_FILE_KEY}" \
                    -backend-config="region=${AWS_REGION}"
                """
            }
        }
        stage ('format') {
            when {
                expression {
                    params.ACTION == 'format'
                }
            }
            steps {
                sh """
                terraform fmt
                """
            }
        }
        stage ('validate') {
            when {
                expression {
                    params.ACTION == 'validate'
                }
            }
            steps {
                sh """
                terraform validate
                """
            }
        }
        stage ('plan') {
            when {
                expression {
                    params.ACTION == 'plan'
                }
            }
            steps {
                sh """
                terraform plan -var-file=${TFVARS_FILE}
                """
            }
        }
        stage ('apply') {
            when {
                expression {
                    params.ACTION == 'apply'
                }
            }
            steps {
                timeout(time: 300, unit: 'SECONDS') {
                    input message: 'Are you sure You want to APPLY the changes?', ok: 'yes', submitter: 'fpdevil,sampath'
                }
                sh """
                terraform apply -var-file=${TFVARS_FILE} --auto-approve
                """
            }
        }
        stage ('destroy') {
            when {
                expression {
                    params.ACTION == 'destroy' 
                }
            }
            steps {
                timeout(time: 300, unit: 'SECONDS') {
                    input message: 'Are you sure You want to DESTROY the infra?', ok: 'yes', submitter: 'fpdevil,sampayj'
                }
                sh """
                terraform destroy -var-file=${TFVARS_FILE} --auto-approve
                """
            }
        }
    }
}
