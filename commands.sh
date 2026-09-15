#!/bin/bash
set -e

# Ensure script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root."
    exit 1
fi

echo "=== Running bootstrap script ==="

# ==============================
# Install basic tools
# ==============================
dnf install -y ca-certificates curl wget unzip git yum-utils dnf-plugins-core
update-ca-trust

# ==============================
# Install Java 17
# ==============================
dnf install -y java-17-openjdk

# ==============================
# Install Jenkins
# ==============================
echo "Installing Jenkins..."
curl -fsSL --tlsv1.2 https://pkg.jenkins.io/redhat-stable/jenkins.repo -o /etc/yum.repos.d/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
dnf install -y jenkins

systemctl enable jenkins
systemctl start jenkins

# ==============================
# Install Docker
# ==============================
echo "Installing Docker..."
dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
dnf install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

systemctl enable docker
systemctl start docker

# Add Jenkins and ec2-user to docker group
if ! getent group docker >/dev/null; then
    groupadd docker
fi
usermod -aG docker jenkins
usermod -aG docker ec2-user

# Ensure docker socket permissions
if [ -S /var/run/docker.sock ]; then
    chown root:docker /var/run/docker.sock
    chmod 660 /var/run/docker.sock
fi

# Restart services
systemctl restart docker
systemctl restart jenkins
sleep 10

# ==============================
# Install Terraform
# ==============================
echo "Installing Terraform..."
dnf config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
dnf install -y terraform

# ==============================
# Install kubectl
# ==============================
echo "Installing kubectl..."
K8S_VERSION=$(curl -fsSL https://dl.k8s.io/release/stable.txt)
curl -fsSL -o /usr/local/bin/kubectl https://dl.k8s.io/release/${K8S_VERSION}/bin/linux/amd64/kubectl
chmod +x /usr/local/bin/kubectl

# ==============================
# Install Minikube
# ==============================
echo "Installing Minikube..."
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
install minikube-linux-amd64 /usr/local/bin/minikube
rm -f minikube-linux-amd64

# ==============================
# Configure Jenkins user environment
# ==============================
echo "Configuring Jenkins user environment..."

# Minikube home
sudo -u jenkins mkdir -p /var/lib/jenkins/.minikube
sudo -u jenkins mkdir -p /var/lib/jenkins/.kube

# ==============================
# Generate SSH key for Terraform/AWS
# ==============================
echo "Generating SSH key for AWS EC2 access..."
sudo -u jenkins mkdir -p /var/lib/jenkins/.ssh
sudo -u jenkins ssh-keygen -t rsa -b 4096 -f /var/lib/jenkins/.ssh/portfolio-key -N ""
chown -R jenkins:jenkins /var/lib/jenkins/.ssh
chmod 600 /var/lib/jenkins/.ssh/portfolio-key

# ==============================
# Preconfigure AWS credentials for Jenkins
# ==============================
echo "Setting up AWS credentials for Jenkins..."
AWS_DIR="/var/lib/jenkins/.aws"
mkdir -p $AWS_DIR
cat > $AWS_DIR/credentials <<EOF
[default]
aws_access_key_id = YOUR_AWS_ACCESS_KEY_ID
aws_secret_access_key = YOUR_AWS_SECRET_ACCESS_KEY
EOF

chown -R jenkins:jenkins $AWS_DIR
chmod 600 $AWS_DIR/credentials

echo "=== Bootstrap script completed ==="
