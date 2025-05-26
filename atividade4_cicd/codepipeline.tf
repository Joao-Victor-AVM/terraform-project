# Referência à role existente do CodePipeline
data "aws_iam_role" "codepipeline_role" {
  name = "codepipeline-role"
}

# Bucket para armazenar artefatos do pipeline
resource "aws_s3_bucket" "artifact_store" {
  bucket = "jrlb-jvavm-pipeline"
}

# CodePipeline
resource "aws_codepipeline" "app_pipeline" {
  name     = "jrlb-jvavm-todolist-pipeline"
  role_arn = data.aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.artifact_store.bucket
    type     = "S3"
  }

  stage {
    name = "Source"
    action {
      name             = "GitHub_Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["source_output"]
      configuration = {
        Owner      = split("/", var.github_repo)[0]
        Repo       = split("/", var.github_repo)[1]
        Branch     = "main"
        OAuthToken = var.github_token
      }
    }
  }

  stage {
    name = "Build"
    action {
      name             = "App_Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.build_project.name
      }
    }
  }
}
