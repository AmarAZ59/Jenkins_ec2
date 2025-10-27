pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'ap-southeast-1'
    }

    stages {
        stage('Launch EC2') {
            steps {
                echo "Launching EC2 instance..."
                sh '''
                chmod +x launch-ec2.sh
                ./launch-ec2.sh
                '''
            }
        }

        stage('Verify Instance') {
            steps {
                echo "Verifying running instances..."
                sh 'aws ec2 describe-instances --filters Name=tag:Name,Values=Jenkins-EC2 --output table'
            }
        }
    }
}
