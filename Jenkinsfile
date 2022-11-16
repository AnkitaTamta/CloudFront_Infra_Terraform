#!groovy​

// Provides different CREDS for AWS depending which environment is being used
switch("${env.JOB_NAME}".split('_')[3].toLowerCase()) 
{
  case ["dev","qa"]:
    aws_key_id = "access_key_tf"
    aws_secret_key = "secret_access_key_tf"
    statebucket_name="demo-fe-infra-state"
    statelocktable_name="demo-fe-infra-state-lock"
  break
  case ["stg","prod"]:
    aws_key_id = "access_key_tf"
    aws_secret_key = "secret_access_key_tf"
    statebucket_name="demo-fe-prod-infra-state"
    statelocktable_name="demo-fe-prod-infra-state-lock"
  break
  default:
    println "Cannot recognize the environment provided"
}

// Terraform apply or plan via the Makefile
def TerraApply(String ServiceToDeploy, String Environment, String TerraAction, String StateBucketName, String StateLockTableName) {
    sh """
        set +x
        echo "=== Terraform ${TerraAction} for ${ServiceToDeploy} in ${Environment} ==="
        STATEBUCKETNAME=${StateBucketName} STATELOCKTABLENAME=${StateLockTableName} SERVICE=${ServiceToDeploy} WORKSPACE=${Environment} make first-run
        STATEBUCKETNAME=${StateBucketName} STATELOCKTABLENAME=${StateLockTableName} SERVICE=${ServiceToDeploy} WORKSPACE=${Environment} make init
        STATEBUCKETNAME=${StateBucketName} STATELOCKTABLENAME=${StateLockTableName} SERVICE=${ServiceToDeploy} WORKSPACE=${Environment} make ${TerraAction}
        """
}

pipeline {
    agent any
    parameters {
        choice(
          name: 'Environment',
          choices: "${env.JOB_NAME}".split('_')[3],
          description: 'Developer is choosing which environment to target to identify the accompanied S3 bucket and CF URL.'
        )
        choice(
          name: 'Action',
          choices: 'plan\napply\nplan-destroy\ndestroy',
          description: 'Select action for terraform'
        )
        booleanParam(
            name: 'fe',
            defaultValue: false,
            description: 'Creation of s3 bucket, bucket policy, cloudfront url, and cloudfront in selected environment for deployment of other pipelines'
        )
    }
    stages {
        stage('fe') {
             when {
                expression {
                    params.fe == true
                }
            }
            environment {
                  AWS_ACCESS_KEY_ID = credentials("${aws_key_id}")
                  AWS_SECRET_ACCESS_KEY = credentials("${aws_secret_key}")
                  STATEBUCKET = "${statebucket_name}"
                  STATELOCKTABLE = "${statelocktable_name}"
            }
            steps {
                script {
                    TerraApply("fe", params.Environment, params.Action, env.STATEBUCKET, env.STATELOCKTABLE)
                }
            }
        }
    }
}
