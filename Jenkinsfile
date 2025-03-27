pipeline {
    agent any  // This tells Jenkins to run the pipeline on any available agent

    tools {
        maven 'Maven'  // Make sure you have a Maven tool configured in Jenkins
    }

    environment {
        // Define environment variables that can be used throughout the pipeline
        SERVER = 'root@167.172.157.217'
        JAR_FILE = 'my-java-project-1.0-SNAPSHOT.jar'  // Update with the actual JAR file name
        DEPLOY_DIR = '/opt/my-java-app'
        SERVICE_NAME = 'my-java-app'
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from the Git repository
                git branch: 'main', url: 'https://github.com/Soumyapadma03/ansible-deployment.git'  // link to your repo
            }
        }

        stage('Build JAR') {
            steps {
                // Building the Java application using Maven
                sh 'mvn -f Documents/my-java-project/pom.xml clean package'  // This should now work if Maven is configured correctly
            }
        }

        stage('Deploy JAR to Server') {
            steps {
                // Copy the JAR file to the server and restart the service using Ansible
                ansiblePlaybook(
                    playbook: 'dodeploy.yml',  // Path to your Ansible playbook
                    inventory: 'inventory.ini',  // Path to your Ansible inventory file
                    extraVars: [jarFilePath: JAR_FILE, deployDir: DEPLOY_DIR]  // Pass the variables to the playbook
                )
            }
        }

        stage('Restart Service') {
            steps {
                // Restart the Java service on the server using Ansible
                ansiblePlaybook(
                    playbook: 'dorestart.yml',  // Path to the playbook to restart the service
                    inventory: 'inventory.ini'  // Path to your Ansible inventory file
                )
            }
        }
    }

    post {
        success {
            echo 'Deployment was successful!'
        }
        failure {
            echo 'Deployment failed.'
        }
    }
}

