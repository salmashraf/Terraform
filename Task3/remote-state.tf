/*resource "aws_s3_bucket" "terraform_state" {
bucket = ""

lifecycle {
    prevent_destroy = true 
}

}

resource "aws_s3_bucket_versioning" "enabled" {
 bucket= aws_s3_bucket.terraform_state.id
 versioning_configuration {
    status = "Enabled"
 }

} */
 # to allow state lock 

/*resource "aws_dynamodb_table" "terraform_locks" {
 name = ""
 billing_mode = ""
 hash_key = "" 

 attribute {
    name = ""
    type = "" 
 }

  terraform {
    backend "s3" {
        bucket = ""
        key = ""
        region = ""
        dynamodb_table = ""
        encrypt = true 
    }
 } 
} */