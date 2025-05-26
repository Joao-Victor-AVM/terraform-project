data "aws_iam_role" "codebuild_role" {
  name = "codebuild-role"
}

resource "aws_codebuild_project" "build_project" {
  name         = "jrlb-jvavm-image-app"
  service_role = data.aws_iam_role.codebuild_role.arn

  source {
    type      = "GITHUB"
    location  = "https://github.com/Joao-Victor-AVM/Image_Aplication"
    buildspec = "buildspec.yml"
  }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:5.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true

    environment_variable {
      name  = "ECR_REPO"
      value = aws_ecr_repository.app_repo.repository_url
    }

    environment_variable {
      name  = "CLUSTER_NAME"
      value = data.aws_eks_cluster.eks.name
    }

    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      value = "eu-central-1"
    }
  }

  artifacts {
    type = "NO_ARTIFACTS"
  }
}
