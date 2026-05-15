#=======================================================
# DYNAMODB TABLE
# Stores persistent visitor counter data
#======================================================

resource "aws_dynamodb_table" "visitors" {
  name         = var.table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"


  attribute {
    name = "id"
    type = "S"

  }
}
