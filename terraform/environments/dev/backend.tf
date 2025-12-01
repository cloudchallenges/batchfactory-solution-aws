# terraform {
#   backend "s3" {
#     bucket         = "YOUR_TFSTATE_BUCKET"
#     key            = "batchfactory/terraform/environments/dev/terraform.tfstate"
#     region         = "us-east-1"
#     dynamodb_table = "terraform-locks"
#     encrypt        = true
#   }
# }
