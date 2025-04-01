pipeline {
    agent any 
    // input parameters as a choice
    // Select the approrpiate Environment and Terraform workflow
    parameters {
        choice(
            name: 'ENVIRONMENT',
            choices: ['dev', 'test', 'stage', 'prod'],
            description: 'Select the appropriate Environment'
        )
        choice(
            name: 'ACTION',
            choices: "format\nvalidate\nplan\napply\ndestroy",
            description: 'Choose a Terraform workflow to execute'
        )
    }

    // environment variables
    environment {
        S3_BUCKET = "svcapi-tf-s3"
        AWS_REGION = "us-east-2"
        STATE_FILE_KEY = "${params.ENVIRONMENT}/terraform.tfstate"
        TFVARS_FILE="${params.ENVIRONMENT}.tfvars"
    }

    // pipeline stages to be triggered
    stages {
        // the 'terraform init' stage will be executed unconditionally
        stage ('init') {
            steps {
                sh """
                terraform init \
                -reconfigure \
                -backend-config="bucket=${S3_BUCKET}" \
                -backend-config="key=${STATE_FILE_KEY}" \
                -backend-config="region=${AWS_REGION}" \
                --no-color
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
                echo "Executing Terraform action # ${params.ACTION}"
                terraform fmt --no-color
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
                echo "Executing Terraform action # ${params.ACTION}"
                terraform validate --no-color
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
                echo "Executing Terraform action # ${params.ACTION}"
                terraform plan -var-file=${TFVARS_FILE} --no-color
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
                echo "Executing Terraform action # ${params.ACTION}"
                terraform apply -var-file=${TFVARS_FILE} --auto-approve --no-color
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
                    input message: 'Are you sure You want to DESTROY the infra?', ok: 'yes', submitter: 'fpdevil,sampath'
                }
                sh """
                echo "Executing Terraform action # ${params.ACTION}"
                terraform destroy -var-file=${TFVARS_FILE} --auto-approve --no-color
                """
            }
        }
    }
}
