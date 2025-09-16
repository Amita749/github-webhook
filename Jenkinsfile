pipeline {
    agent any

    environment {
        // Source Org
        SOURCE_CONSUMER_KEY = credentials('SOURCE_CONSUMER_KEY')
        SOURCE_USERNAME     = credentials('SOURCE_USERNAME')
        SOURCE_ALIAS        = 'SourceOrg'

        // Target Org
        TARGET_CONSUMER_KEY = credentials('TARGET_CONSUMER_KEY')
        TARGET_USERNAME     = credentials('TARGET_USERNAME')
        TARGET_ALIAS        = 'TargetOrg'

        // Common
        JWT_KEY   = credentials('sf_jwt_key')   // Secret File (server.key)
        SFDC_HOST = 'https://test.salesforce.com'
        
    }

    stages {
        stage('Authenticate Source Org') {
            steps {
                bat "sf auth:jwt:grant --client-id %SOURCE_CONSUMER_KEY% --jwt-key-file \"%JWT_KEY%\" --username %SOURCE_USERNAME% --instance-url %SFDC_HOST% --alias %SOURCE_ALIAS%"
            }
        }

        stage('Authenticate Target Org') {
            steps {
                bat "sf auth:jwt:grant --client-id %TARGET_CONSUMER_KEY% --jwt-key-file \"%JWT_KEY%\" --username %TARGET_USERNAME% --instance-url %SFDC_HOST% --alias %TARGET_ALIAS%"
            }
        }

        stage('Retrieve Metadata from Source Org') {
            steps {
                bat "sf project retrieve start --manifest manifest/package.xml --target-org %SOURCE_ALIAS% --wait 10 --verbose"
            }
        }

        stage('Deploy Metadata to Target Org') {
            steps {
                bat "sf project deploy start --manifest manifest/package.xml --target-org %TARGET_ALIAS% --wait 10 --verbose"
            }
        }
    }

    post {
        always {
            echo "Deployment pipeline finished."
        }
    }
}
