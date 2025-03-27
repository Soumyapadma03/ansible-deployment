pipeline {
    agent any  // This tells Jenkins to run the pipeline on any available agent

    environment {
        // Define variables to use throughout the pipeline
        SERVER = 'root@167.172.157.217'
        JAR_FILE = 'my-java-project-1.0-SNAPSHOT.jar'  // Update with the actual JAR file name
        DEPLOY_DIR = '/opt/my-java-app'
        SERVICE_NAME = 'my-java-app'
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from the Git repository
                git branch: 'main', url: 'https://github.com/Soumyapadma03/ansible-deployment.git'  // link to my repo
            }
        }

        stage('Build JAR') {
            steps {
                // Build the Java application using Maven
                sh 'mvn clean package'  // Make sure this works with your project setup (e.g., Maven/Gradle)
            }
        }

        stage('Deploy JAR to Server') {
            steps {
                // Copy the JAR file to the server and restart the service using Ansible
                ansiblePlaybook(
                    playbook: 'dodeploy.yml',  // my path to your Ansible playbook
                    inventory: 'inventory.ini',  // my path to your Ansible inventory file
                    extraVars: [jarFilePath: JAR_FILE, deployDir: DEPLOY_DIR]  // Pass the variables to the playbook
                )
            }
        }

        stage('Restart Service') {
            steps {
                // Restart the Java service on the server using Ansible
                ansiblePlaybook(
                    playbook: 'dorestart.yml',  // to restart playbook
                    inventory: 'inventory.ini'  // my path to the Ansible inventory
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

