resource "aws_kms_key" "backup" {
  description             = "Backup KMS key"
  deletion_window_in_days = 10
}

resource "aws_backup_vault" "backup" {
  name        = var.name
  kms_key_arn = aws_kms_key.backup.arn
}


resource "aws_iam_role" "aws-tfbackup" {
  name               = var.name
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": ["sts:AssumeRole"],
      "Effect": "allow",
      "Principal": {
        "Service": ["backup.amazonaws.com"]
      }
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "aws-backup-tf" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
  role       = aws_iam_role.aws-tfbackup.name
}

