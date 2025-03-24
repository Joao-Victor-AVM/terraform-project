terraform {
    backend "s3" {
        key = "terraform/tfstate.tfstate"
        bucket = "tfstate-jrlb-jvavm"
        region = "us-east-1"
    }
}