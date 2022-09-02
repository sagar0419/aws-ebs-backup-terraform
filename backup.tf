resource "aws_backup_plan" "backup" {
  name = var.name

  rule {
    rule_name         = var.rule_name
    target_vault_name = aws_backup_vault.backup.name
    schedule          = "cron(5 * ? * * *)"

    lifecycle {
      delete_after = 14
    }
  }

  advanced_backup_setting {
    backup_options = {
      WindowsVSS = "enabled"
    }
    resource_type = "EC2"
  }
}

resource "aws_backup_selection" "backup_selection" {
  iam_role_arn = aws_iam_role.aws-tfbackup.arn
  name         = var.name
  plan_id      = aws_backup_plan.backup.id

  selection_tag {
    type  = "STRINGEQUALS"
    key   = "Name"
    value = "backup_volume_name"
  }
}