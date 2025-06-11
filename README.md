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
```

## Install All Tools Inside Jenkins Container


Run this after the container starts:
```bash
docker cp install_jenkins_k8s_docker_tools.sh jenkins:/tmp/
docker exec -it jenkins bash -c "chmod +x /tmp/install_jenkins_k8s_docker_tools.sh && /tmp/install_jenkins_k8s_docker_tools.sh"
```


Tools installed:

    Docker CLI

    Docker Compose (v2)

    AWS CLI v2

    kubectl

    eksctl

