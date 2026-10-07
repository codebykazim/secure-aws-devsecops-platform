# --- Elastic Container Registry (ECR) ---
resource "aws_ecr_repository" "app_repo" {
  name                 = "devsecops-app"
  image_tag_mutability = "MUTABLE"

  # Enable built-in vulnerability scanning on push!
  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "devsecops-ecr-repo"
  }
}

# --- IAM Role for Jenkins Agent ---
# This role allows the EC2 instance to interact with AWS services without needing access keys.
resource "aws_iam_role" "jenkins_agent_role" {
  name = "jenkins-agent-ecr-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# Attach the managed policy for ECR Power User access
resource "aws_iam_role_policy_attachment" "ecr_poweruser_attach" {
  role       = aws_iam_role.jenkins_agent_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}

# Create an Instance Profile to attach the role to the EC2 instance
resource "aws_iam_instance_profile" "jenkins_agent_profile" {
  name = "jenkins-agent-instance-profile"
  role = aws_iam_role.jenkins_agent_role.name
}
