# Jenkins CI/CD with Docker, AWS CLI, Kubectl, and Eksctl on Amazon Linux

This setup runs Jenkins in a Docker container on Amazon Linux EC2. Jenkins is configured with all the necessary tools to build Docker containers, interact with AWS, and deploy to an EKS Kubernetes cluster.

---

## 📁 Folder Structure

```text
.
├── docker-compose.yaml
├── install_jenkins_k8s_docker_tools.sh
├── jenkins/
│   └── init.groovy.d/
│       └── security.groovy
└── README.md

