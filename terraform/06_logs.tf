resource "aws_cloudwatch_log_group" "django-log-group" {
  name              = "/ecs/sns-django-app"
  retention_in_days = var.log_retention_in_days
}

resource "aws_cloudwatch_log_stream" "django-log-stream" {
  name           = "sns-django-app-log-stream"
  log_group_name = aws_cloudwatch_log_group.django-log-group.name
}


