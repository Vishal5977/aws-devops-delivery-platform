pipeline {
  agent any

  environment {
    AWS_REGION   = 'ap-south-1'
    ECR_REGISTRY = '711387129093.dkr.ecr.ap-south-1.amazonaws.com'
    IMAGE_NAME   = 'aws-devops-platform-app'
    NAMESPACE    = 'devops-platform'
    KUBECONFIG   = '/var/lib/jenkins/.kube/config'
  }

  stages {
    stage('Validate') {
      steps {
        sh 'python3 -m py_compile app/app.py'
      }
    }

    stage('Build') {
      steps {
        script {
          env.IMAGE = "${ECR_REGISTRY}/${IMAGE_NAME}:${BUILD_NUMBER}"
        }
        sh 'docker build -t "$IMAGE" .'
      }
    }

    stage('Push to Amazon ECR') {
      steps {
        sh '''
          aws ecr get-login-password --region "$AWS_REGION" | \
            docker login --username AWS --password-stdin "$ECR_REGISTRY"
          docker push "$IMAGE"
        '''
      }
    }

    stage('Deploy to k3s') {
      steps {
        sh '''
          kubectl apply -f kubernetes/namespace.yaml
          set +x
          ECR_PASSWORD="$(aws ecr get-login-password --region "$AWS_REGION")"
          kubectl create secret docker-registry ecr-registry \
              --namespace "$NAMESPACE" \
              --docker-server="$ECR_REGISTRY" \
              --docker-username=AWS \
              --docker-password="$ECR_PASSWORD" \
              --dry-run=client -o yaml | kubectl apply -f -
          unset ECR_PASSWORD
          set -x
          envsubst < kubernetes/deployment.yaml | kubectl apply -f -
          kubectl apply -f kubernetes/service.yaml
          kubectl apply -f kubernetes/ingress.yaml
          kubectl rollout status deployment/delivery-api --namespace "$NAMESPACE" --timeout=180s
        '''
      }
    }
  }

  post {
    always {
      sh 'docker image prune -f || true'
    }
  }
}
