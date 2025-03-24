resource "aws_s3_bucket" "jrlb_jvavm_state"{
    bucket = "tfstate-jrlb-jvavm"

    tags = {
        Aluno = "jrlb_jvavm"
        Periodo = "8"
    }
}